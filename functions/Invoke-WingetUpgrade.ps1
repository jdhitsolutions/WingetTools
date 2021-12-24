Function Invoke-WingetUpgrade {
    [cmdletbinding(SupportsShouldProcess)]
    Param()

    $up = Get-WingetUpgrade | Group-Object -Property ID |
    Where-Object Count -eq 1
    foreach ($item in $up) {
        $source = $item.group.source
        $newver = $item.group.available
        if ($item.Group.version -ne 'unknown' -AND ($pscmdlet.ShouldProcess("$($item.name) to version $newver"))) {
            winget upgrade --id $item.name --source $source --silent --accept-package-agreements --accept-source-agreements
        }
    }
}
