Function Get-WingetUpgrade {
    [cmdletbinding()]
    Param()

    Write-Verbose "Starting $($MyInvocation.MyCommand)"
    $up = (winget upgrade).trim() | where-object {$_ -match "\d+\.\d+"}

    #| Select-Object -Skip 3 | Select-Object -SkipLast 1
    Write-Verbose "Found $($up.count) available upgrades"

    [regex]$r = "^(?<name>.*)\s+(?<id>\S+)\s+(?<version>\S+)\s+(?<available>\S+)\s+(?<source>\w+)$"
    foreach ($item in $up) {
        $g = $r.Match($item).groups
        Write-Verbose "Processing package id $($g["id"].value)"
        [pscustomobject]@{
            PSTypename = "wingetUpgrade"
            Name       = $g["name"].value
            ID         = $g["id"].value
            Version    = $g["version"].value
            Available  = $g["available"].value
            Source     = $g["source"].value
        }
    } #foreach item
    Write-Verbose "Ending $($MyInvocation.MyCommand)"
}
