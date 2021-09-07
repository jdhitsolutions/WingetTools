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
Get-WGReleaseNote [-AsMarkdown] [-Online] [<CommonParameters>]
```

## DESCRIPTION

This command will query the Github repository for the winget project and display the release note for the latest version. You can also display it in markdown format or go to the online version.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-WGReleaseNote

Name       : Windows Package Manager v1.0.11692
Version    : v1.0.11692
Published  : 6/24/2021 8:32:44 PM
Prerelease : False
Notes      : This release fixes a few bugs. The first one is related to users
             and installers executing [Ctrl]+[c]. The next is a fallback when
...
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
Windows Package Manager v1.0.11692 v1.0.11692 6/24/2021 8:32:44 PM
```

The output is an object.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

### ReleaseNote

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Install-WinGet](Install-WinGet.md)
