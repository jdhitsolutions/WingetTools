Function Invoke-WGUpgrade {
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = "id")]
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
            ParameterSetName = "ID"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$ID
    )

    Begin {
        Write-Verbose "Starting $($MyInvocation.MyCommand)"
        if ($ID) {
            $inputobject = Get-WGUpgrade -id $ID
        }
    } #begin
    Process {
        if ($inputobject) {
            foreach ($item in $InputObject) {
                if ($pscmdlet.ShouldProcess($item.id, "Upgrade from $($item.version) to $($item.Available)")) {
                    if ($item.source) {
                        winget upgrade --id $item.id --source $item.source --silent --accept-package-agreements --accept-source-agreements
                    }
                    else {
                        winget upgrade --id $item.id --silent --accept-package-agreements --accept-source-agreements
                    }
                }
            } #foreach
        }
        else {
            Write-Warning "No packages detected."
        }
    } #process

    End {
        Write-Verbose "Ending $MyInvocation.MyCommand"
    } #end
}
