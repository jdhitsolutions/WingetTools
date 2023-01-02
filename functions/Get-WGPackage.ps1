<#
As was made evident by Issue #1, Winget output is not always in English, and
not every property is returned from the Winget show command. I think the best
course of action is to turn the raw winget data into a list object and then
use the Find() method to find specific values like Version,Description, and Moniker.

However there is still an issue of what to do with non-English results.
#>
Function Get-WGPackage {
    [cmdletbinding(DefaultParameterSetName = "name")]
    [OutputType("WGPackage")]
    Param(
        [Parameter(
            ParameterSetName = "name",
            Position = 0,
            Mandatory,
            ValueFromPipelineByPropertyName,
            HelpMessage = "Specify the package name"
            )]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(
            ParameterSetName = "id",
            ValueFromPipelineByPropertyName,
            HelpMessage = "Specify the package ID"
            )]
        [ValidateNotNullOrEmpty()]
        [string]$ID,
        [Parameter(
            ParameterSetName = "moniker",
            HelpMessage = "Specify the moniker"
            )]
        [ValidateNotNullOrEmpty()]
        [string]$Moniker,
        [Parameter(
            ParameterSetname = "input",
            ValueFromPipeline,
            HelpMessage = "Pipe a winget search to this function"
            )]
        [object[]]$InputObject,

        [Parameter(HelpMessage = "Specify a winget source")]
        [ValidateNotNullOrEmpty()]
        [string]$Source = "winget"

    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        #some regex patterns
        [regex]$rxIDAll = "(?<=\s)[\w-+]{3,}\.[\w-+]{3,}(\.[\w-+]{3,})?"

        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Using source $source"
        $winget = Get-WGPath
        #9/20/2022 If winget path has a space enclose in quotes. Issue #11 -JDH
        if ($winget -match "\s") {
            $winget  = "&'$winget'"
        }
        $cmdText = "$winget show --source $source"

        Switch ($PSCmdlet.ParameterSetName) {
            "Name" {
                if ($name) {
                    $cmdText += " --name '$name'"
                }
            }
            "ID" {
                $cmdText += "  --id $id"
            }
            "Moniker" {
                $cmdText += " --moniker $moniker"
            }
        }

        #create a scriptblock
        $sb = [scriptblock]::create($cmdText)

    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Using Parameter set $($PSCmdlet.ParameterSetName)"

        if ($InputObject) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Processing winget output by input"
            $data = $InputObject | Where-Object { $rxIDAll.IsMatch($InputObject) } |
            ForEach-Object {
                $id = $rxIDAll.Match($_).Value
                if ($id -match "\w+") {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Show $id"
                    &$winget show --id $id --source $source | Where-Object {$_ -notmatch "(\d+%|\d MB|\s+)$" -and $_.length -gt 0}
                }
                else {
                    write-Warning $_
                }
            }
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Processed $($data.count) item(s)"
        }
        else {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Invoking: $cmdtext"
            $data = Invoke-Command -ScriptBlock $sb | Where-Object {$_ -notmatch "(\d+%|\d MB|\s+)$" -and $_.length -gt 0}
        }

        if ($data -match "Multiple apps found") {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Multiple packages found"
            #Get all the IDS
            $IDs = $rxIDAll.Matches($data).value

            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Processing $($IDS.count) packages"
            $out = foreach ($item in $ids) {
                #get the exact package to avoid problems when there are duplicate names
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Retrieving $item"
                _convert (&$winget show -e $item | Where-Object {$_ -notmatch "(\d+%|\d MB|\s+)$" -and $_.length -gt 0})
            }
        } #if multiple found
        elseif ($data -match "no package found") {
            if ($cmdText) {
                Write-Warning $cmdText
            }
            elseif ($InputObject) {
                Write-Warning ($InputObject | Out-String)
            }
            Write-Warning ($data | Out-String).Trim()
        }
        elseif ($data) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Converting winget data"
            $data | Out-String | Write-Verbose
            $out = _convert $data
        } #else

        #insert the typename
        $out

    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

}