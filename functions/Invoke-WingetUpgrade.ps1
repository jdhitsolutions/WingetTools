Function Invoke-WGUpgrade {
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = "id")]
    [OutputType("None")]
    Param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            HelpMessage = "Specify a wingetUpgrade object",
            ParameterSetName = "input"
        )]
        [ValidateNotNullOrEmpty()]
        [object]$InputObject,

        [Parameter(
            Mandatory,
            HelpMessage = "Specify a package by ID. Wildcards are permitted.",
            ParameterSetName = "id"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$ID,

        [Parameter(HelpMessage = "Update all packages.", ParameterSetName = "all")]
        [switch]$All,

        [Parameter(HelpMessage = "Upgrade packages even if their current version cannot be determined. This requires -all", ParameterSetName = "all")]
        [switch]$IncludeUnknown
    )

    Begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand)"
        $winget = Get-WingetPath
    } #begin
    Process {
        #set a flag indicating items were process in this script block
        $processed = $True
        Write-Verbose "Detected parameter set $($pscmdlet.ParameterSetName)"
        if ($pscmdlet.ParameterSetName -eq 'id') {
            $inputobject = Get-WGUpgrade -ID $ID
        }

        if ($inputobject -AND $($pscmdlet.ParameterSetName -match "id|input")) {
            Write-Verbose "Processing input"
            foreach ($item in $InputObject) {
                if ($pscmdlet.ShouldProcess($item.id, "Upgrade from $($item.version) to $($item.Available)")) {
                    if ($item.source) {
                        & $winget upgrade --id $item.id --source $item.source --silent --accept-package-agreements --accept-source-agreements
                    }
                    else {
                        & $winget upgrade --id $item.id --silent --accept-package-agreements --accept-source-agreements
                    }
                }
            } #foreach
        }
        elseif ($pscmdlet.ParameterSetName -eq 'all' -AND $IncludeUnknown) {
            if ($pscmdlet.ShouldProcess("all installed and unknown packages")) {
                & $winget upgrade --all --include-unknown --silent
            }
        }
        elseif ($pscmdlet.ParameterSetName -eq 'all') {
            if ($pscmdlet.ShouldProcess("all installed")) {
                & $winget upgrade --all --silent
            }
        }
        else {
            Write-Warning "No packages detected."
        }
    } #process

    End {
        If (-not $processed) {
            Write-Warning "No packages detected from the pipeline"
        }
        Write-Verbose "Ending $($MyInvocation.MyCommand)"
    } #end
}
