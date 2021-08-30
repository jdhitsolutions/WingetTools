Function Get-WGPackage {
#TODO Add -Tags parameter

    [cmdletbinding(DefaultParameterSetName = "name")]
    [OutputType("WGPackage")]
    Param(
        [Parameter(ParameterSetName = "name", Position = 0, HelpMessage = "Specify the package name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(ParameterSetName = "id", HelpMessage = "Specify the package ID")]
        [ValidateNotNullOrEmpty()]
        [string]$ID,
        [Parameter(ParameterSetName = "moniker", HelpMessage = "Specify the moniker")]
        [ValidateNotNullOrEmpty()]
        [string]$Moniker
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        #some regex patterns
        [regex]$rxIDAll = "(?<=\s)[\w-+]{3,}\.[\w-+]{3,}(\.[\w-+]{3,})?"

        Switch ($PSCmdlet.ParameterSetName) {
            "Name" {
                if ($name) {
                    $cmdText = "winget show --name $name"
                }
                else {
                    $cmdText = "winget show"
                }
            }
            "ID" {
                $cmdText = "winget show --id $id"
            }
            "Moniker" {
                $cmdText = "winget show --moniker $moniker"
            }
        }

        #create a scriptblock
        $sb = [scriptblock]::create($cmdText)

    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Invoking: $cmdtext"

        $data = Invoke-Command -ScriptBlock $sb

        if ($data -match "Multiple apps found") {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Multiple packages found"
            #Get all the IDS
            $IDs = $rxIDAll.Matches($data).value

            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Processing $($IDS.count) packages"
            foreach ($item in $ids) {
                #get the exact package to avoid problems when there are duplicate names
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Retrieving $item"
                _convert (winget show -e $item)
            }

        } #if multiple found
        elseif ($data -match "no package found") {
            write-Warning ($data | Out-String).Trim()
        }
        else {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Converting winget data"
            $data | Out-String | Write-Verbose
            $data | _convert
        } #else

    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

}