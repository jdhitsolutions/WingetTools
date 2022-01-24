---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/3fVkHKQ
schema: 2.0.0
---

# Get-WGUpgrade

## SYNOPSIS

Get available winget upgrades.

## SYNTAX

### name (Default)

```yaml
Get-WGUpgrade [<CommonParameters>]
```

### Name

```yaml
Get-WGUpgrade [-Name <String>] [<CommonParameters>]
```

### ID

```yaml
Get-WGUpgrade [-ID <String>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to get information about available winget upgrades. You can then manually decide what to upgrade using winget or pipe to Invoke-WingetUpgrade.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-WGUpgrade

Name                                        ID                                           Version       Available
----                                        --                                           -------       ---------
MozBackup                                   JasnaPaka.MozBackup                          Unknown       1.5.1
Ruby                                        RubyInstallerTeam.Ruby                       3.0.1-1       3.1.0-1
Microsoft Visual C++ 2013 RedistributablΓÇª Microsoft.VC++2013Redist-x64                 12.0.30501.0  12.0.40664.0
Java 8                                      Oracle.JavaRuntimeEnvironment                8.0.3010.9    8.0.3110.11
...
```

Get all available updates.

### Example 2

```powershell
PS C:\> get-wgupgrade p*

Name                                      ID
----                                      --
Private Internet Access                   PrivateInternetAccess.PrivateInternet…
PowerToys (Preview)                       Microsoft.PowerToys
```

Get upgrades with a name that begins with P.

### Example 3

```powershell
PS C:\> Get-WGUpgrade -id *toys

Name                                      ID                  Version Available
----                                      --                  ------- ---------
PowerToys (Preview)                       Microsoft.PowerToys 0.47.0  0.51.1
```

Get upgrades by ID.

## PARAMETERS

### -ID

Specify a package by ID. Wildcards are permitted.

```yaml
Type: String
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Name

Specify a package by name. Wildcards are permitted.

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### wingetUpgrade

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Invoke-WGUpgrade](Invoke-WGUpgrade.md)
