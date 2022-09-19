---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/3SVsASZ
schema: 2.0.0
---

# Invoke-WGUpgrade

## SYNOPSIS

Rufen Sie ein Winget-Upgrade für alle verfügbaren Upgrades auf.

## SYNTAX

### id (Default)

```yaml
Invoke-WGUpgrade -ID <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### input

```yaml
Invoke-WGUpgrade [-InputObject <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### all

```yaml
Invoke-WGUpgrade [-All] [-IncludeUnknown] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Dieser Befehl wurde entwickelt, um das Upgrade von Winget-Paketen zu vereinfachen. Der Befehl überspringt Pakete mit unbekannten Versionen. Der Installationsprozess akzeptiert alle Lizenzen und Vereinbarungen und verwendet die Silent-Winget-Option.

Beachten Sie, dass winget beim Versuch, das Update aufzurufen, immer noch auf ein Problem stoßen kann.

## EXAMPLES

### Example 1

```powershell
PS C:\> Invoke-WGUpgrade -id Microsoft.VC++2015-2019Redist-x64

Found Microsoft Visual C++ 2015-2019 Redistributable (x64) [Microsoft.VC++2015-2019Redist-x64] Version 14.29.30135.0
This application is licensed to you by its owner.
Microsoft is not responsible for, nor does it grant any licenses to, third-party packages.
Downloading https://download.visualstudio.microsoft.com/download/pr/d3cbdace-2bb8-4dc5-a326-2c1c0f1ad5ae/9B9DD72C27AB1DB081DE56BB7B73BEE9A00F60D14ED8E6FDE45DAB3E619B5F04/VC_redist.x64.exe
Successfully verified installer hash
Starting package install...
Successfully installed
```

### Example 2

```powershell
PS C:\> Get-WGUpgrade -Name p* | Invoke-WGUpgrade -WhatIf
What if: Performing the operation "Upgrade from 3.2.0+06857 to 3.3.1+06924" on target "PrivateInternetAccess.PrivateInternetAccess".
What if: Performing the operation "Upgrade from 0.58.0 to 0.61.1" on target "Microsoft.PowerToys".
What if: Performing the operation "Upgrade from 3.10.3 to 3.10.6" on target "Python.Python.3".
```

Sie können die Ausgabe von Get-WGUpgrade an diesen Befehl weiterleiten.

### Example 3

```powershell
PS C:\> Get-WGUpgrade | Out-GridView -OutputMode Multiple | Invoke-WGUpgrade
```

Leiten Sie die Liste der verfügbaren Upgrades an Out-Gridview weiter, wo Sie Elemente auswählen können. Invoke-WGUpgrade installiert dann die ausgewählten Upgrades.

### Example 4

```powershell
PS C:\> Invoke-WGUpgrade -all
```

Dies ist das Äquivalent zum Ausführen von winget upgrade --all.

## PARAMETERS

### -Confirm

Fordert Sie zur Bestätigung auf, bevor das Cmdlet ausgeführt wird.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Zeigt, was passieren würde, wenn das Cmdlet ausgeführt wird.
Das Cmdlet wird nicht ausgeführt.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID

Geben Sie ein Paket nach ID an. Wildcards sind erlaubt.

```yaml
Type: String
Parameter Sets: id
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Geben Sie ein wgUpgrade-Objekt an.

```yaml
Type: Object
Parameter Sets: input
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -All

Update all packages.

```yaml
Type: SwitchParameter
Parameter Sets: all
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeUnknown

Aktualisieren Sie Pakete, auch wenn ihre aktuelle Version nicht ermittelt werden kann. Dies erfordert den Parameter -All.

```yaml
Type: SwitchParameter
Parameter Sets: all
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

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-WGUpgrade](Get-WGUpgrade.md)

[Get-WGInstalled](Get-WGInstalled.md)
