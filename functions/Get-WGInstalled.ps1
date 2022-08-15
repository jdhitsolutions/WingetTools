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
        $Winget = Get-WingetPath
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
                            $out = $null
                        }
                        elseif ($VersionString -match "[\<\>]") {
                            $out = ($VersionString -replace $matches.values, "").Trim()
                        }
                        else {
                            $out = $VersionString.Trim()
                        }
                        $out
                    }

                    try {
                        $show = & $wingetPath show --id $pkg.PackageIdentifier --source $source

                        [regex]$rxname = "(?<=\w\s).*(?=\s\[[\S\.]+\])"
                        $installed = _parseVersion $pkg.version
                        $online = _parseVersion (($show | Select-String "Version:") -split "Version: ")[1].trim()

                        @{
                            Name             = $rxname.match($($show | Select-String "Found\s")).value
                            ID               = $pkg.PackageIdentifier
                            InstalledVersion = $installed
                            OnlineVersion    = $online
                            Publisher        = $(Try { (($show | Select-String "Publisher:") -split "Publisher: ")[1].trim() } Catch { $null })
                            PublisherURL     = $(Try { (($show | Select-String "Publisher Url:") -split "Publisher Url: ")[1].trim() } Catch { $null })
                            Author           = $(Try { (($show | Select-String "Author:") -split "Author: ")[1].trim() } Catch { $null })
                            Moniker          = $(Try { (($show | Select-String "Moniker:") -split "Moniker: ")[1].trim() } Catch {$null })
                            Description      = $(Try { (($show | Select-String "Description:") -split "Description: ")[1].trim() } Catch { $null })
                            Homepage         = $(Try { (($show | Select-String "Homepage:") -split "Homepage: ")[1].trim() } Catch { $null })
                            Source           = $Source
                        } #output hash
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
                    $r = $_ | Receive-Job
                    [pscustomobject]@{
                        PSTypeName       = "WGInstalled"
                        Name             = $r.name
                        ID               = $r.id
                        InstalledVersion = $r.InstalledVersion
                        OnlineVersion    = $r.OnlineVersion
                        Publisher        = $r.Publisher
                        PublisherUrl     = $r.PublisherURL
                        Author           = $r.Author
                        Moniker          = $r.Moniker
                        Description      = $r.Description
                        Homepage         = $r.Homepage
                        Source           = $r.Source
                        Computername     = $env:computername
                    } #output object
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
            Remove-Item $tmpFile -whatif:$false
        }
        if (Get-Job -Name wg) {
            #always remove the threadjob
            Remove-Job -Name wg -Force -whatif:$false
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

