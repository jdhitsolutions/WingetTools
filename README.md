# WingetTools

[![PSGallery Version](https://img.shields.io/powershellgallery/v/WingetTools.png?style=for-the-badge&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/WingetTools/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/WingetTools.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/WingetTools/)

The WingetTools module is a PowerShell wrapper around the winget command-line tool which is Microsoft's latest package manager and installer. Winget is a command-line tool, not a PowerShell command. The commands in the WingetTools module are designed to make using winget a little more PowerShell friendly.

## [Install-WinGet](docs/Install-Winget.md)

Until winget is publically available in the Microsoft Store, you can download and install the latest version from Github. This command __*must be run in a Windows PowerShell session*__ in Windows 10 or Windows 11. The package requires the DesktopAppInstaller package. If it isn't found, it will be downloaded and installed.

![install winget](images/install-winget.png)

## [Get-WGReleaseNote](docs/Get-WGReleaseNote.md)

This command will query the Github repository for the winget project and display the release note for the latest version.

![Get release note](images/get-wgreleasenote.png)

You can also display it in markdown format, which is helpful if running in PowerShell 7.

![release note markdown](images/releasenote-markdown.png)

You also have an option to go online to view the release note.

## Get-WGPackage

This command is a PowerShell wrapper aroung winget.cmd that will get a package and create an object you can use in PowerShell.

![get winget package](images/get-wgpackage-1.png)

The command has a default table view but the output object has other properties you might want to use.

```text
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
```

The command typically gets a single package, but you can pipe a winget search command to it.

![get winget package search](images/get-wgpackage-2.png)

## Get-WGInstalled

This command will get a list of all packages installed with winget. These will be packages with winget as the source.

```powershell
Get-WGInstalled | Select Name,ID,Version,Homepage | Out-Gridview
```

![get winget installed](images/get-wginstalled.png)

## Issues

If there are problems with commands in this module, try running the winget command directly. Report problems to the module's Github repository at <https://github.com/jdhitsolutions/WingetTools/issues>.

Visit the winget Github repository for more information about the project at <https://github.com/microsoft/winget-cli>.

Last Updated _2021-09-15 13:51:49Z_
