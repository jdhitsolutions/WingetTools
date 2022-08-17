Function Get-WGUpgrade {
    [cmdletbinding(DefaultParameterSetName="name")]
    [outputType("wgUpgrade")]
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
        $pkg = [wgUpgrade]::new( $item.name, $item.id,$item.InstalledVersion,$item.OnlineVersion)
        $pkg.source =$item.source
        $pkg
    }
    Write-Verbose "Ending $($MyInvocation.MyCommand)"
}

