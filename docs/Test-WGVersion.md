---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version:
schema: 2.0.0
---

# Test-WGVersion

## SYNOPSIS

Test Winget version

## SYNTAX

```yaml
Test-WGVersion [-Quiet] [<CommonParameters>]
```

## DESCRIPTION

Test-WGVersion is a simple command you use to discover if you need to update winget.

## EXAMPLES

### Example 1

```powershell
PS C:\> Test-WGVersion

Installed    Online       Update    Command
---------    ------       ------    -------
1.1.13405    1.1.12653    False     C:\Users\Jeff\AppData\Local\Microsoft\Windo…
```

The default output is an object showing the currently installed version and the latest stable version online. If an update is available, and you are running in the PowerShell console or VS Code, the Update value will be displayed in Green.

### Example 2

```powershell
PS C:\> Test-WGVersion -Quiet
False
```

Run the test and get a simple, Boolean result indicating if an update is available.

## PARAMETERS

### -Quiet

Get a Boolean result indicating if an update is available.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.SwitchParameter

## OUTPUTS

### Boolean

### WGVersion

## NOTES

## RELATED LINKS

[Get-WGReleaseNote](Get-WGReleaseNote.md)
