

Function Get-WGInstalled {
    [cmdletbinding()]
    [OutputType("wgPackage")]
    Param(
        [Parameter(Position = 0, HelpMessage = "Specify a winget source")]
        [ValidateNotNullOrEmpty()]
        [string]$Source = "winget"
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        $tmpFile = "$env:temp\wgExport_{0}.json" -f (Get-Date -format yyyymmdd)
        $wp = @{
            Activity = $myinvocation.MyCommand
            Status = "Getting winget package information"
            CurrentOperation = "winget export"
            PercentComplete = 0
        }
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Building list of packages with a winget source"
        Write-Progress @wp
        [void](winget export -s winget -o $tmpFile)
        if (Test-Path -path $tmpFile) {
            #import the json file
            $wp.currentOperation = "Importing temporary JSON data"
            $wp.Percentcomplete = 2
            Write-Progress @wp
            $json = Get-Content -path $tmpFile | ConvertFrom-Json
            #get the packages
            $i = 0
            $count = $json.Sources.packages.count
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Found $count packages"
            $wp.status = "Getting package details"
            foreach ($pkg in $json.Sources.packages) {
                $i++
                [int]$pct = ($i/$count)*100
                $wp.currentOperation = $pkg.PackageIdentifier
                $wp.PercentComplete = $pct
                Write-Progress @wp
                Get-WGPackage -id $pkg.PackageIdentifier -source $Source
            }
        }
        else {
            Write-Warning "There was a problem getting a list of installed packages."
        }

    } #process

    End {

        if (Test-Path -path $tmpFile) {
            Remove-Item $tmpFile
        }
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"

    } #end

} #close Get-WGInstalled