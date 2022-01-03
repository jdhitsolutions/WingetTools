#this command will work in PowerShell 7.2 and later
Function Install-WinGet {
    #Install the latest package from GitHub
    [cmdletbinding(SupportsShouldProcess)]
    [alias("iwg")]
    [OutputType("None")]
    [OutputType("Microsoft.Windows.Appx.PackageManager.Commands.AppxPackage")]
    Param(
        [Parameter(HelpMessage = "Install the latest preview build.")]
        [switch]$Preview,
        [Parameter(HelpMessage = "Display the AppxPackage after installation.")]
        [switch]$Passthru
    )

    Write-Verbose "[$((Get-Date).TimeofDay)] Starting $($myinvocation.mycommand)"

    if ($Iscoreclr -AND ($PSVersionTable.PSVersion -le 7.2)) {
        Write-Warning "If running this command in PowerShell 7, you need at least version 7.2."
        return
    }

    #test for requirement
    $Requirement = Get-AppPackage Microsoft.VCLibs.140.00.UWPDesktop

    if (-Not $requirement) {
        Write-Verbose "Installing Desktop App requirement"
        Try {
            $vclib = Join-Path -Path $env:temp -ChildPath "Microsoft.VCLibs.x64.14.00.Desktop.appx"
            Invoke-WebRequest -Uri "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -UseBasicParsing -OutFile $vclib -ErrorAction stop
            if (Test-Path $vclib) {
                Add-AppxPackage -Path $vclib -ErrorAction Stop
            }
            else {
                Throw "Failed to find $vclib"
            }
        }
        Catch {
            Throw $_
        }
    }

    $uri = "https://api.github.com/repos/microsoft/winget-cli/releases"

    Try {
        Write-Verbose "[$((Get-Date).TimeofDay)] Getting information from $uri"
        $get = Invoke-RestMethod -Uri $uri -Method Get -ErrorAction stop
        if ($preview) {
            Write-Verbose "[$((Get-Date).TimeofDay)] Getting latest preview release"
            $data = ($get | where-object {$_.Prerelease} | Select-Object -first 1).Assets | Where-Object name -Match 'msixbundle'
        }
        else {
            Write-Verbose "[$((Get-Date).TimeofDay)] Getting latest stable release"
            $data = ($get | where-object {-Not $_.Prerelease} | Select-Object -first 1).Assets | Where-Object name -Match 'msixbundle'

        }
        #$data = $get | Select-Object -first 1

        $appx = $data.browser_download_url
        #$data.assets[0].browser_download_url
        Write-Verbose "[$((Get-Date).TimeofDay)] $appx"
        If ($pscmdlet.ShouldProcess($appx, "Downloading asset")) {
            $file = Join-Path -Path $env:temp -ChildPath $data.name

            Write-Verbose "[$((Get-Date).TimeofDay)] Saving to $file"
            Invoke-WebRequest -Uri $appx -UseBasicParsing -DisableKeepAlive -OutFile $file

            Write-Verbose "[$((Get-Date).TimeofDay)] Adding Appx Package"
            Add-AppxPackage -Path $file -ErrorAction Stop

            if ($passthru) {
                Get-AppxPackage microsoft.desktopAppInstaller
            }
        }
    } #Try
    Catch {
        Write-Verbose "[$((Get-Date).TimeofDay)] There was an error."
        Throw $_
    }
    Write-Verbose "[$((Get-Date).TimeofDay)] Ending $($myinvocation.mycommand)"
}