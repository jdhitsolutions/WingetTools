---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/3nauPEz
schema: 2.0.0
---

# Get-WGReleaseNote

## SYNOPSIS

Get the latest release note for winget.

## SYNTAX

```yaml
Get-WGReleaseNote [-AsMarkdown] [-Online] [-Preview] [<CommonParameters>]
```

## DESCRIPTION

This command will query the Github repository for the winget project and display the release note for the latest version. You can also display it in markdown format or go to the online version.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-WGReleaseNote

Name       : Windows Package Manager v1.1.12653
Version    : v1.1.12653
Published  : 9/27/2021 6:08:01 PM
Prerelease : False
Notes      : This release represents our Windows Package Manager 1.release
             candidate build for Windows 10 (1809+).

             Experimental features have been disabled in this release. We will
             follow this release with another Pre-release "developer"
             build at GitHub so users can continue with experimental features
             available.

             # Bugs
             #797 Silent install of "winget install git.git" is not working
             #1497 Make rename retry more frequently for longer, then try
             making a hardlink
Link       : https://github.com/microsoft/winget-cli/releases/tag/v1.1.12653
```

The default output.

### Example 2

```powershell
PS C:\> Get-WGReleaseNote -asmarkdown | Show-Markdown
```

If running in PowerShell 7, you can use the markdown cmdlets.

### Example 3

```powershell
PS C:\> Get-WGReleaseNote | Select-Object Name,Version,Published

Name                               Version    Published
----                               -------    ---------
Windows Package Manager v1.1.12653 v1.1.12653 9/27/2021 6:08:01 PM
```

The output is an object.

### Example 4

```powershell
PS C:\> Get-WGReleaseNote -Preview


Name       : Windows Package Manager v1.1.12701
Version    : v1.1.12701
Published  : 9/28/2021 10:30:01 AM
Prerelease : True
Notes      : This release is the first development build after the Windows
             Package Manager 1.1 release candidate build for Windows 10
             (1809+).

             Experimental features have been enabled in this release. This
             build will be released to Windows Insider Dev builds, and
             Windows Package Manager Insiders.
```

Get the release note for the latest preview.

## PARAMETERS

### -AsMarkdown

Create a markdown document.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: md

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Online

Open the release note location online using your default web browser.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Preview

Get latest preview release.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

### WGReleaseNote

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Install-WinGet](Install-WinGet.md)

[Test-WGVersion](Test-WGVersion.md)
