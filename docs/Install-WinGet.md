---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/2WYteX6
schema: 2.0.0
---

# Install-WinGet

## SYNOPSIS

Install the latest winget release from Github.

## SYNTAX

```yaml
Install-WinGet [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Until winget is publically available in the Microsoft Store, you can download and install the latest version from Github. This command must be run in a Windows PowerShell session in Windows 10 or Windows 11. The package requires the DesktopAppInstaller package. If it isn't found, it will be downloaded and installed.

## EXAMPLES

### Example 1

```powershell
PS C:\> Install-Winget
```

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

### -Passthru

Display the AppxPackage after installation.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

### AppxPackage

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-WGReleaseNote](Get-WGReleaseNote.md)
