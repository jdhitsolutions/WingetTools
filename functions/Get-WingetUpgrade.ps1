Function Get-WGUpgrade {
    [cmdletbinding(DefaultParameterSetName="name")]
    [outputType("wingetUpgrade")]
    Param(
        [Parameter(Position = 0, HelpMessage = "Specify a package by name. Wildcards are permitted.",ParameterSetName = "Name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(HelpMessage = "Specify a package by ID. Wildcards are permitted.",ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [string]$ID
    )

    Write-Verbose "Starting $($MyInvocation.MyCommand)"
    #get installed packaged with an available update and that have an InstalledVersion value

    if ($Name) {
        Write-Verbose "Filtering by name: $name"
        $list = Get-WGInstalled | Where-Object {($_.Update) -AND ($_.name -like $name )-And ($_.InstalledVersion)}
    }
    elseif ($ID) {
        Write-Verbose "Filtering by id: $id"
        $list = Get-WGInstalled | Where-Object {($_.Update) -AND ($_.id -like $ID) -And ($_.InstalledVersion)}
    }
    else {
        Write-Verbose "Returning all upgrades"
        $list = Get-WGInstalled | Where-Object {$_.Update -And ($_.InstalledVersion)}
    }

    Write-Verbose "Found $($list.count) matching packages"
    foreach ($item in $list) {
        $pkg = [wingetUpgrade]::new( $item.name, $item.id,$item.InstalledVersion,$item.OnlineVersion)
        $pkg.source =$item.source
        $pkg
    }
    Write-Verbose "Ending $($MyInvocation.MyCommand)"
}

return

#this is the old version which won't be loaded
Function Get-WGUpgrade {
    [cmdletbinding(DefaultParameterSetName="name")]
    [outputType("wingetUpgrade")]
    Param(
        [Parameter(Position = 0, HelpMessage = "Specify a package by name. Wildcards are permitted.",ParameterSetName = "Name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(HelpMessage = "Specify a package by ID. Wildcards are permitted.",ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [string]$ID
    )

    Write-Verbose "Starting $($MyInvocation.MyCommand)"
    #create a list to hold the results
    $list = [System.Collections.Generic.list[object]]::New()
    $up = (winget upgrade).trim() | Where-Object { $_ -match "\d+\.\d+\s(?!MB)" }

    Write-Verbose "Found $($up.count) available upgrades"

    #a regex pattern to parse the output
    #it looks like winget version 1.2.10271 changed the output for the upgrade command
    #Revising the regex pattern. Issue #3
    #"^(?<name>.*)\s+(?<id>\S+)\s+(?<version>\S+)\s+(?<available>\S+)$"

    #updated regex again for Issue #4
    [regex]$r = "^(?<name>.*?(?=\s*\w+\.))\s+(?<id>\S+)\s+(?<version>\S+)\s+(?<available>\S+)"
    #"^(?<name>.*)\s+(?<id>\S+)\s+(?<version>\S+)\s+(?<available>\S+)\s+(?<source>\w+)$"
    foreach ($item in $up) {
        $g = $r.Match($item).groups
        Write-Verbose "Processing package id $($g["id"].value)"
<#         $pkg = [pscustomobject]@{
            PSTypename = "wingetUpgrade"
            Name       = $g["name"].value
            ID         = $g["id"].value
            Version    = $g["version"].value
            Available  = $g["available"].value
            Source     = $g["source"].value
        } #>
        $pkg = [wingetUpgrade]::new( $g["name"].value, $g["id"].value,$g["version"].value,$g["available"].value)
        $pkg.source = $g["source"].value
        $list.Add($pkg)
    } #foreach item

    if ($Name) {
        Write-Verbose "Filtering by name: $name"
        $list | Where-Object {$_.name -like $name}
    }
    elseif ($ID) {
        Write-Verbose "Filtering by id: $id"
        $list | Where-Object {$_.id -like $id}
    }
    else {
        Write-Verbose "Returning all upgrades"
        $list
    }
    Write-Verbose "Ending $($MyInvocation.MyCommand)"
}
