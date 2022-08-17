---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version:
schema: 2.0.0
---

# Get-WGPath

## SYNOPSIS

Get the Winget executable path

## SYNTAX

```yaml
Get-WGPath [<CommonParameters>]
```

## DESCRIPTION

Normally, you will run winget under your user context. But if you are running winget under the System context, that account won't be able to locate winget.exe. This command will return the full path to the winget.exe file depending on the user context.

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
