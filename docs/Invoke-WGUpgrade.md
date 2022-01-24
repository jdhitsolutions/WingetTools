---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/3FVQsOn
schema: 2.0.0
---

# Invoke-WGUpgrade

## SYNOPSIS

Invoke a Winget upgrade on all available upgrades.

## SYNTAX

### id (Default)

```yaml
Invoke-WGUpgrade [-WhatIf] [-Confirm] [<CommonParameters>]
```

### input

```yaml
Invoke-WGUpgrade [-InputObject <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ID

```yaml
Invoke-WGUpgrade [-ID <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command is designed to make it easy to upgrade winget packages. The command will skip packages with unknown versions. The installation process accepts all licenses and agreements, and uses the silent winget option.

Be aware that winget may still encounter a problem attempting to invoke the update.

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
What if: Performing the operation "Upgrade from 3.1.2+06767 to 3.2.0+06857" on target "PrivateInternetAccess.PrivateInternetAcceΓÇª".
What if: Performing the operation "Upgrade from 0.47.0 to 0.51.1" on target "Microsoft.PowerToys".
```

You can pipe output from Get-WGUpgrade to this command.

### Example 3

```powershell
PS C:\> Get-WGUpgrade | Out-GridView -OutputMode Multiple | Invoke-WGUpgrade
```

Pipe the list of available upgrades to Out-Gridview where you can select items. Invoke-WGUpgrade will then install the selected upgrades.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

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

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

Specify a package by ID. Wildcards are permitted.

```yaml
Type: String
Parameter Sets: ID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specify a wingetUpgrade object

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-WGUpgrade](Get-WGUpgrade.md)
