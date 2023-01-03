Function Get-WGInstalled {
    [cmdletbinding()]
    [OutputType("WGInstalled")]
    Param(
        [Parameter(Position = 0, HelpMessage = "Specify a winget source")]
        [ValidateNotNullOrEmpty()]
        [string]$Source = "winget"
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        $tmpFile = "$env:temp\wgExport_{0}.json" -f (Get-Date -Format yyyymmdd)
        $Winget = Get-WGPath
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Building list of packages with a winget source"
        [void](& $winget export -s winget -o $tmpFile --include-versions)
        if (Test-Path -Path $tmpFile) {
            #import the json file
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Importing temporary JSON data"

            $json = Get-Content -Path $tmpFile | ConvertFrom-Json
            #get the packages
            $count = $json.Sources.packages.count
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Found $count packages. Getting details."

            $jobList = [system.collections.generic.list[object]]::new()
            $wingetPath = $winget
            foreach ($pkg in $json.Sources.packages) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] $($pkg.PackageIdentifier)"
                $i++
                #9 August 2022 Using Threadjobs to get online package details for better scaling - JDH
                $sb = {
                    Param([object]$pkg, [string]$source, [string]$wingetPath)
                    Function _parseVersion {
                        #parse out odd characters from version strings
                        [cmdletbinding()]
                        Param([string]$VersionString)

                        if ($versionString -match "unknown") {
                            return $null
                        } elseif ($VersionString -match "[\<\>]") {
                            $out = ($VersionString -replace $matches.values, "").Trim()
                        } else {
                            $out = $VersionString.Trim()
                        }

                        # Using [system.Version] helps standardization here. But if there are less
                        # than 4 section in the version number, they are considered -1 instead of 0.
                        # Reference: https://learn.microsoft.com/en-us/dotnet/api/system.version
                        $out = [System.Version]$out
                        if ($out.Revision -eq -1) { $revision = 0 } else { $revision = $out.Revision }
                        if ($out.Build -eq -1) { $build = 0 } else { $build = $out.Build }
                        if ($out.Minor -eq -1) { $minor = 0 } else { $minor = $out.Minor }
                        if ($out.Major -eq -1) { $major = 0 } else { $major = $out.Major }

                        $safe = [System.Version]::new($major, $minor, $build, $revision)
                        $safe
                    }

                    try {
                        $show = & $wingetPath show --id $pkg.PackageIdentifier --source $source
                        $pkg | Add-Member -MemberType NoteProperty -Name show -Value $show -PassThru -Force
                    } #Try
                    catch {
                        #$show | Out-String | Write-Host -fore red
                        Write-Warning "There was an unknown problem with $($pkg.PackageIdentifier)"
                    }
                }

                $joblist.add($(Start-ThreadJob -ScriptBlock $sb -ArgumentList $pkg, $source, $wingetPath -Name wg))

            } #foreach pkg

            #process jobs
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting thread job results"
            Do {
                $joblist.FindAll({ $args[0].state -eq 'Completed' }) |
                ForEach-Object {
                    #convert the job output to a defined object
                    $jobresult = $_ | Receive-Job
                    $show = $jobresult.show | Where-Object { $_ -notmatch "(\d+%|\d MB|\s+)$" -and $_.length -gt 0 }
                    $show | Out-String | Write-Debug
                    Try {
                        $yml = $show.replace(" - ", " ") | Select-Object -Skip 1 | Where-Object { $_ -match "^(\s+)?(\b(\w+)\b).*:" } | ConvertFrom-Yaml -ErrorAction stop
                    }
                    Catch {
                        Write-Warning "Failed to convert to YAML"
                        $show | Out-String | Write-Warning
                    }
                    [regex]$rxname = "(?<name>(?<=\w\s).*)(?=\s\[(?<id>[\S\.]+)\])"
                    $id = $jobresult.PackageIdentifier
                    #$rxname.match($show[0]).groups["id"].value
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting installed version for $id"
                    # 8/16/2022 Need to account for multiple versions JDH
                    $installed = _parseVersion $jobresult.version
                    #($json.sources.packages.where({$_.packageIdentifier -eq $id}).version)
                    $online = _parseVersion (($show | Select-String "$($localized.version):") -split "$($localized.version): ")[1].trim()
                    $out = [wginstalled]::new()

                    $out.Name = $rxname.match($show[0]).groups["name"].value
                    $out.ID = $id
                    $out.InstalledVersion = $installed
                    $out.Version = $online
                    $out.Publisher = $yml.$($localized.Publisher)
                    $out.PublisherUrl = $yml.$($localized.PublisherURL)
                    $out.PublisherSupportUrl = $yml.$($localized.PublisherSupportUrl)
                    $out.Author = $yml.$($localized.Author)
                    $out.Moniker = $yml.$($localized.Moniker)
                    $out.Description = $yml.$($localized.Description)
                    $out.Homepage = $yml.$($Localized.homepage)
                    $out.Source = $Source
                    $out


                    [void]$joblist.remove($_)
                }
            } Until ($jobList.count -eq 0)
        }
        else {
            Write-Warning "There was a problem getting a list of installed packages."
        }
    } #process

    End {
        if (Test-Path -Path $tmpFile) {
            #always remove the temp file
            Remove-Item $tmpFile -WhatIf:$false
        }
        if (Get-Job -Name wg) {
            #always remove the threadjob
            Remove-Job -Name wg -Force -WhatIf:$false
        }
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"

    } #end

} #close Get-WGInstalled

Update-TypeData -TypeName WGInstalled -MemberType ScriptProperty -MemberName Update -Value {
    <#
    compare versions first at [version] type, then as a simple string comparison
    to determine if there is an upgrade available.
    #>
    $a = $null
    $z = $null
    if (([version]::tryparse($this.onlineversion, [ref]$a)) -AND ([version]::tryparse($this.installedversion, [ref]$z))) {
        $a -gt $z
    }
    elseif ($null -eq $this.InstalledVersion) {
        $False
    }
    else {
        $this.installedversion -ne $This.onlineversion
    }

} -Force

