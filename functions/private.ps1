
#define a private function to convert the output
function _convert {
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory)]
        [object]$Package
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Processing package data"
        $hash = [ordered]@{PSTypename = "WGPackage" }
        #need to take non-English results into account Issue #1
        #[regex]$rxFound = "(?<=\s).*\]"
        [regex]$rxname = "(?<=\w\s).*(?=\s\[[\S\.]+\])" #".*(?=\s\[[\w\.]+\])"
        #"(?<=Found\s).*(?=\s\[)"
        [regex]$rxID = "(?<=\s\[).*(?=\])"
        #it is possible the ANSI scheme might not be green, so be more generic
        [regex]$rxansi = "$([char]0x1b)\[(\w+;)"

        #a hashtable to define properties from the winget show output. The value should be the line number
        $propertyHash = [ordered]@{
            NameID           = 0
            Version          = 1
            Publisher        = 2
            PublisherURL     = 3
            PublisherSupport = 4
            Author           = 5
            Moniker          = 6
            Description      = 7
            Homepage         = 8
        }

    }
    Process {
        # uncomment for debugging and development
        #$global:wp = $package
        Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Package length is $($Package.Length)"
        #7 Feb 2022 Need to take non-English results into account. Issue #1.
        if ($package.length -gt 1) {

            #parse the data into a list
            $data = _parseShowData $package

            $pkgname = $rxname.Match($data[0]).value
            Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Processing $pkgname"
            $pkgid = $rxID.match($data[0]).value

            #strip off ANSI
            Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Adding Name: $pkgname"
            $hash.Add("Name", $rxansi.Replace($pkgname, ""))
            Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Adding ID: $pkgid"
            $hash.Add("ID", $rxansi.replace($pkgid, ""))

            #add remaining properties

            #revised for Issue #2
            $propertyHash.GetEnumerator() | Select-Object -skip `1 | foreach-Object {
                $key = $_.key
                $find = $data.Where({$_ -match "$($key):"})
                if ($find) {
                    $value = $find.split("$($key):")[1].trim()
                }
                else {
                    $value = $null
                }
                $hash.Add($key,$Value)
            }
            <#
            $propertyHash.GetEnumerator() | Select-Object -Skip 1 | ForEach-Object {
                Try {
                    $propName = $_.Key
                    $propValue = ($data.item($_.value) -split ":", 2)[1].trim()
                    $hash.Add($propName, $propValue)
                }
                Catch {
                    Write-Warning "Failed to parse $propName for $pkgName"
                    $global:d = $data
                }
            #>


        } #if found
        else {
            Write-Warning "Failed to find a matching package. $package"
        }

    }  #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Creating object"
        if ($hash) {
            [pscustomobject]$hash
        }
    }
} #convert

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
