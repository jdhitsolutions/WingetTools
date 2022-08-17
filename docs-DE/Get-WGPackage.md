---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/3jQh9MH
schema: 2.0.0
---

# Get-WGPackage

## SYNOPSIS

Informieren Sie sich über ein Winget-Paket

## SYNTAX

### name (Default)

```yaml
Get-WGPackage [[-Name] <String>] [-Source <String>] [<CommonParameters>]
```

### id

```yaml
Get-WGPackage [-ID <String>] [-Source <String>] [<CommonParameters>]
```

### moniker

```yaml
Get-WGPackage [-Moniker <String>] [-Source <String>] [<CommonParameters>]
```

### input

```yaml
Get-WGPackage [-InputObject <String[]>] [-Source <String>] [<CommonParameters>]
```

## DESCRIPTION

Dieser Befehl ist ein PowerShell-Wrapper um winget.command, der ein Paket abruft und ein Objekt erstellt, das Sie in PowerShell verwenden können.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-WGPackage -name "Foxit PDF Reader"

Name             ID                Version      Description
----             --                -------      -----------
Foxit PDF Reader Foxit.FoxitReader 11.2.1.53537 Foxit is a powerful PDF reader
                                                for viewing, filling out forms
                                                and more.
```

Holen Sie sich ein Paket mit seinem Namen.

### Example 2

```powershell
PS C:\> Get-WGPackage -id "Microsoft.Powershell.Preview" | Select-Object *

Name                  : PowerShell Preview
ID                    : Microsoft.PowerShell.Preview
Version               : 7.3.0.3
Publisher             : Microsoft Corporation
Publisher URL         : https://github.com/PowerShell/PowerShell
Publisher Support URL : https://github.com/PowerShell/PowerShell/issues
Author                : Microsoft Corporation
Moniker               : pwsh-preview
Description           : PowerShell is a cross-platform (Windows, Linux, and
                        macOS) automation and configuration tool/framework that
                        works well with your existing tools and is optimized
                        for dealing with structured data (e.g. JSON, CSV, XML,
                        etc.), REST APIs, and object models.
Homepage              : https://microsoft.com/PowerShell
```

Die Ausgabe ist ein reichhaltiges Objekt.

### Example 3

```powershell
PS C:\> winget search --tag powerbi | Get-WGPackage | Select-Object Name,ID,Version


Name                      ID                  Version
----                      --                  -------
DAX Studio                DaxStudio.DaxStudio 2.17.3.683
Microsoft PowerBI Desktop Microsoft.PowerBI   2.102.845.0
```

Sie können die Ergebnisse eines Winget-Suchbefehls an diese Funktion weiterleiten.

## PARAMETERS

### -ID

Specify the package ID.

```yaml
Type: String
Parameter Sets: id
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -InputObject

Leiten Sie eine Winget-Suche an diese Funktion weiter.

```yaml
Type: String[]
Parameter Sets: input
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Moniker

Geben Sie den Winget-Moniker an.

```yaml
Type: String
Parameter Sets: moniker
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

Geben Sie den Winget-Paketnamen an.

```yaml
Type: String
Parameter Sets: name
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Source

Geben Sie eine Winget-Quelle an. Derzeit gibt es wirklich nur eine einzige Quelle, aber dies könnte sich irgendwann ändern.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: winget
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

## OUTPUTS

### WGPackage

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-WGInstalled](Get-WGInstalled.md)
