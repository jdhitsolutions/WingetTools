---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/3A5B7tT
schema: 2.0.0
---

# Install-WinGet

## SYNOPSIS

Installieren Sie die neueste Winget-Version von Github.

## SYNTAX

```yaml
Install-WinGet [-Preview] [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Bis winget öffentlich im Microsoft Store verfügbar ist, können Sie die neueste Version von Github herunterladen und installieren. Dieser Befehl muss in einer Windows PowerShell-Sitzung unter Windows 10 oder Windows 11 ausgeführt werden. Das Paket erfordert das Paket Microsoft.VCLibs.140.00.UWPDesktop. Wenn es nicht gefunden wird, wird es heruntergeladen und installiert.

## EXAMPLES

### Example 1

```powershell
PS C:\> Install-Winget
```

## PARAMETERS

### -Confirm

Fordert Sie zur Bestätigung auf, bevor das Cmdlet ausgeführt wird.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Passthru

Zeigen Sie das AppxPackage nach der Installation an.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Zeigt, was passieren würde, wenn das Cmdlet ausgeführt wird. Das Cmdlet wird nicht ausgeführt.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Preview

Installieren Sie den neuesten Vorschau-Build.

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

### None

### AppxPackage

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-WGReleaseNote](Get-WGReleaseNote.md)
