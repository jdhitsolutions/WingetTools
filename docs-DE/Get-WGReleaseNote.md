---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/3CfeCp5
schema: 2.0.0
---

# Get-WGReleaseNote

## SYNOPSIS

Holen Sie sich die neuesten Versionshinweise für winget.

## SYNTAX

```yaml
Get-WGReleaseNote [-AsMarkdown] [-Online] [-Preview] [<CommonParameters>]
```

## DESCRIPTION

Dieser Befehl fragt das Github-Repository nach dem Winget-Projekt ab und zeigt die Versionshinweise für die neueste Version an. Sie können es auch im Markdown-Format anzeigen oder zur Online-Version gehen.

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

Die Standardausgabe.

### Example 2

```powershell
PS C:\> Get-WGReleaseNote -asmarkdown | Show-Markdown
```

Bei Ausführung in PowerShell 7 können Sie die Markdown-Cmdlets verwenden.

### Example 3

```powershell
PS C:\> Get-WGReleaseNote | Select-Object Name,Version,Published

Name                               Version    Published
----                               -------    ---------
Windows Package Manager v1.1.12653 v1.1.12653 9/27/2021 6:08:01 PM
```

Die Ausgabe ist ein Objekt.

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

Holen Sie sich die Versionshinweise für die neueste Vorschau.

## PARAMETERS

### -AsMarkdown

Erstellen Sie ein Markdown-Dokument.

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

Öffnen Sie den Speicherort der Versionshinweise online mit Ihrem Standard-Webbrowser.

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

Holen Sie sich die neueste Vorschauversion.

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
