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

### Name (Default)

```yaml
Get-WGUpgrade [-Name <String>] [<CommonParameters>]
```

### ID

```yaml
Get-WGUpgrade [-ID <String>] [<CommonParameters>]
```

## DESCRIPTION

Use this command to get information about available winget upgrades. You can then manually decide what to upgrade using winget or pipe to Invoke-WingetUpgrade. The output will not show any packages where the installed version cannot be determined.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-WGUpgrade

Name                                   ID                                    Installed            Available
----                                   --                                    ---------            ---------
Discord                                Discord.Discord                       1.0.9005             1.0.9006
Visual Studio Community 2019           Microsoft.VisualStudio.2019.Community 16.11.18             16.11.19
Spotify                                Spotify.Spotify                       1.1.91.824.g07f1e963 1.1.93.896.g3ae3b4f3
VSCodium                               VSCodium.VSCodium                     1.71.1.22256         1.71.2.22258
Camtasia                               TechSmith.Camtasia                    22.0.4.39133         22.1.1.39848
Windows Software Development Kit       Microsoft.WindowsSDK                  10.0.22000.832       10.0.22621.1
Microsoft SQL Server Management Studio Microsoft.SQLServerManagementStudio   18.12                18.12.1
PowerToys (Preview)                    Microsoft.PowerToys                   0.62.0               0.62.1
ESET Endpoint Security                 ESET.EndpointSecurity                 9.0.2046.0           9.1.2057.0
```

Get all available updates.

### Example 2

```powershell
PS C:\> get-wgupgrade p*

Name                ID                  Installed Available
----                --                  --------- ---------
PowerToys (Preview) Microsoft.PowerToys 0.62.0    0.62.1
```

Get upgrades with a name that begins with P.

### Example 3

```powershell
PS C:\> Get-WGUpgrade -id micro* | Select-Object Name,Version,Available

Name                                   Version        Available
----                                   -------        ---------
Visual Studio Community 2019           16.11.18       16.11.19
Windows Software Development Kit       10.0.22000.832 10.0.22621.1
Microsoft SQL Server Management Studio 18.12          18.12.1
PowerToys (Preview)                    0.62.0         0.62.1
```

Get upgrades by ID that starts with "micro". Note that the actual object property name, "Version", differs from the formatted column header of "Installed."

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
Accept wildcard characters: False
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
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### wgUpgrade

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Invoke-WGUpgrade](Invoke-WGUpgrade.md)

[Get-WGInstalled](Get-WGInstalled.md)
