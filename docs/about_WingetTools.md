# WingetTools

## about_WingetTools

# SHORT DESCRIPTION

The Wingettools module is a PowerShell wrapper around the winget command-line tool.

# LONG DESCRIPTION

The winget command-line tool is Microsoft's latest package manager and installer. It is a command-line tool, not a PowerShell command. The commands in the WingetTools module are designed to make using winget a little more PowerShell friendly.

## Install-WinGet

Until winget is publically available in the Microsoft Store, you can download and install the latest version from Github. This command must be run in a Windows PowerShell session in Windows 10 or Windows 11. The package requires the
DesktopAppInstaller package. If it isn't found, it will be downloaded and installed.

## Get-WGReleaseNote

This command will query the Github repository for the winget project and display the release note for the latest version. You can also display it in markdown format or go to the online version.

## Get-WGPackage

This command is a PowerShell wrapper aroung winget.cmd that will get a package and create an object you can use in PowerShell. The object has a default table view but the object has other properties.

    Name         : GitHub CLI
    ID           : GitHub.cli
    Version      : 2.0.0
    Publisher    : GitHub, Inc.
    Author       : GitHub, Inc.
    Moniker      : gh
    Description  : GitHubs official command-line tool.
    Homepage     : https://github.com/cli/cli
    License      : MIT License
    License Url  : https://github.com/cli/cli/blob/HEAD/LICENSE
    Type         : Msi
    Locale       : en-US
    Download Url : https://github.com/cli/cli/releases/download/v2.0.0/gh_2.0.0_windows_amd64.msi
    SHA256       : 09761ebfcf1a294b79cf5c820d2a51edca9d5e515cbd1036c45862c462b36189

If you want to get details on multiple packages, pipe a winget search command to this PowerShell command.

    winget search --tag github --source winget  | Get-WGPackage

## Get-WGInstalled

This command will get a list of all packages installed with winget. These will be packages with winget as the source.

## Get-WGUpgrade

This command makes it easier to get PowerShell objects that reflect upgrade packages. The command writes a custom object to the pipeline which is formatted as a table by default. You can use this command to pipe to winget.exe in a ForEach loop to upgrade, or pipe to Invoke-WGUpgrade which supports -WhatIf.

## Invoke-WGUpgrade

This command is a wrapper around the winget upgrade option. The upgrade is done using the package ID and silent install options. The upgrade also accepts all licenses and agreements.

# TROUBLESHOOTING NOTE

If there are problems with commands in this module, try running the winget command directly. Report problems to the module's Github repository at https://github.com/jdhitsolutions/WingetTools/issues.

# SEE ALSO

Visit the winget Github repository for more information about the project at https://github.com/microsoft/winget-cli.

# KEYWORDS

- winget
- packages
