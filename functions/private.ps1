
#define a private function to convert the output
function _convert {
    [cmdletbinding()]
    Param(
        [Parameter(ValueFromPipeline)]
        [object]$Package
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Processing package data"
        $hash = [ordered]@{PSTypename = "WGPackage" }
        [regex]$rxname = "(?<=Found\s).*(?=\s\[)"
        [regex]$rxID = "(?<=\s\[).*(?=\])"
        [regex]$rxansi = "$([char]0x1b)\[96m"
    }
    Process {
        $found = $package | Where-Object { $_ -match "^Found" }
        if ($found) {
            Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] $Found"
            $pkgname = $rxname.Match($found).value
            $pkgid = $rxID.match($found).value
            #strip off ANSI
            Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Adding Name $pkgname"
            $hash.Add("Name", $rxansi.Replace($pkgname, ""))
            Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Adding ID $pkgid"
            $hash.Add("ID", $rxansi.replace($pkgid, ""))
        }
        #filter out blanks
        ($package | Where-Object { $_ -match "\w+:(\s)?\w+" }).foreach( {
                $split = $_.split(":", 2)
                $hash.add($split[0].trim(), $split[1].trim())
            })
    }
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) CONVERT] Creating object"

        [pscustomobject]$hash

    }
} #convert
