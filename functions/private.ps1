
#define a private function to convert the output

Function _convert {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory)]
        [object]$Package
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Processing package data"
    }
    Process {
        Try {
            Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Converting to YAML"
            $yml = $package.replace(" - ", " ") | Select-Object -Skip 1 | Where-Object { $_ -match "^(\s+)?(\b(\w+)\b).*:" } | ConvertFrom-Yaml -ErrorAction stop
        }
        Catch {
            Write-Warning "Failed to convert to YAML. $($_.exception.message)"
            $package | Out-String | Write-Warning
        }

        [regex]$rxname = "(?<name>(?<=\w\s).*)(?=\s\[(?<id>[\S\.]+)\])"
        $online = _parseVersion $yml.$($localized.version)

        $out = [wgPackage]::new()
        $out.Name                = $rxname.match($package[0]).groups["name"].value
        $out.ID                  = $rxname.match($package[0]).groups["id"].value
        $out.Version             = $online
        $out.Publisher           = $yml.$($localized.Publisher)
        $out.PublisherUrl        = $yml.$($localized.PublisherURL)
        $out.PublisherSupportUrl = $yml.$($localized.PublisherSupportUrl)
        $out.Author              = $yml.$($localized.Author)
        $out.Moniker             = $yml.$($localized.Moniker)
        $out.Description         = $yml.$($localized.Description)
        $out.Homepage            = $yml.$($Localized.homepage)
        $out.Source              = $Source

        $out
       <#  [pscustomobject]@{
            Name                = $rxname.match($package[0]).groups["name"].value
            ID                  = $rxname.match($package[0]).groups["id"].value
            Version             = $online
            Publisher           = $yml.$($localized.Publisher)
            PublisherUrl        = $yml.$($localized.PublisherURL)
            PublisherSupportUrl = $yml.$($localized.PublisherSupportUrl)
            Author              = $yml.$($localized.Author)
            Moniker             = $yml.$($localized.Moniker)
            Description         = $yml.$($localized.Description)
            Homepage            = $yml.$($Localized.homepage)
            Source              = $Source
        } #>

    }
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Ending conversion"
    }
}


#parse the winget output into a list object
Function _parseShowData {
    [cmdletbinding()]
    Param ([string[]]$PackageData)

    $list = [System.Collections.Generic.list[string]]::new()
    $list.add($packageData[0])
    for ($i = 1; $i -lt $packagedata.count; $i++) {
        if ($PackageData[$i] -match ":\s\w+") {
            $list.add($PackageData[$i].trim())
        }
    }
    #winget doesn't always return the exact data for every package,
    $list
}
Function _parseVersion {
    #parse out odd characters from version strings
    [cmdletbinding()]
    Param([string[]]$VersionString)

    $out = @()
    foreach ($v in $VersionString) {

        if ($v -match "unknown") {
            $out += $null
        }
        elseif ($v -match "[\<\>]") {
            $out += ($v -replace $matches.values, "").Trim()
        }
        else {
            $out += $v.Trim()
        }
    }

    $out
}