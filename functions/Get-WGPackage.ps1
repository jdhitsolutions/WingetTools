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
        [string[]]$InputObject,

        [Parameter(HelpMessage = "Specify a winget source")]
        [ValidateNotNullOrEmpty()]
        [string]$Source = "winget"

    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        #some regex patterns
        [regex]$rxIDAll = "(?<=\s)[\w-+]{3,}\.[\w-+]{3,}(\.[\w-+]{3,})?"

        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Using source $source"
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Using Parameter set $($PSCmdlet.ParameterSetName)"
        $cmdText = "winget show --source $source"

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

        if ($InputObject) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Processing winget output"
            $data = $InputObject | Where-Object { $rxIDAll.IsMatch($InputObject) } |
            ForEach-Object {
                $id = $rxIDAll.Match($_).Value
                winget show --id $id --source $source
            }
        }
        else {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Invoking: $cmdtext"
            $data = Invoke-Command -ScriptBlock $sb
        }

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
            $data | _convert
        } #else

    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

}