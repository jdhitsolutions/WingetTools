---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/3QA0jQ5
schema: 2.0.0
---

# Get-WGPath

## SYNOPSIS

Rufen Sie den Pfad der ausführbaren Winget-Datei ab

## SYNTAX

```yaml
Get-WGPath [<CommonParameters>]
```

## DESCRIPTION

Normalerweise werden Sie winget in Ihrem Benutzerkontext ausführen. Wenn Sie winget jedoch im Systemkontext ausführen, kann dieses Konto winget.exe nicht finden. Dieser Befehl gibt je nach Benutzerkontext den vollständigen Pfad zur Datei winget.exe zurück.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-WGPath
C:\Users\Jeff\AppData\Local\Microsoft\WindowsApps\Winget.exe
```

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS
