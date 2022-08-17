---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/3GYwrbj
schema: 2.0.0
---

# Test-WGVersion

## SYNOPSIS

Testen Sie die Winget-Version.

## SYNTAX

```yaml
Test-WGVersion [-Quiet] [<CommonParameters>]
```

## DESCRIPTION

Test-WGVersion ist ein einfacher Befehl, mit dem Sie feststellen können, ob Sie winget aktualisieren müssen.

## EXAMPLES

### Example 1

```powershell
PS C:\> Test-WGVersion

Installed    Online       Update    Command
---------    ------       ------    -------
1.1.13405    1.1.12653    False     C:\Users\Jeff\AppData\Local\Microsoft\Windo…
```

Die Standardausgabe ist ein Objekt, das die aktuell installierte Version und die neueste stabile Version online anzeigt. Wenn ein Update verfügbar ist und Sie die PowerShell-Konsole oder VS Code ausführen, wird der Update-Wert in Grün angezeigt.

### Example 2

```powershell
PS C:\> Test-WGVersion -Quiet
False
```

Führen Sie den Test aus und erhalten Sie ein einfaches, boolesches Ergebnis, das angibt, ob ein Update verfügbar ist.

## PARAMETERS

### -Quiet

Rufen Sie ein boolesches Ergebnis ab, das angibt, ob ein Update verfügbar ist.

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
