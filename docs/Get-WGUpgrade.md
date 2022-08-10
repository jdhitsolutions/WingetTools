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

Name                      ID                                            Installed       Available
----                      --                                            ---------       ---------
Visual Studio Community   Microsoft.VisualStudio.2019.Community         16.11.10        16.11.17
2019
CCleaner                  Piriform.CCleaner                             6.00            6.01
Discord                   Discord.Discord                               1.0.9003        1.0.9005
Foxit PDF Reader          Foxit.FoxitReader                             12.0.0.12394    12.0.1.12430
Notepad++                 Notepad++.Notepad++                           8.3.3           8.4.4
...
```

Get all available updates.

### Example 2

```powershell
PS C:\> get-wgupgrade p*

Name                      ID                                            Installed       Available
----                      --                                            ---------       ---------
PowerToys (Preview)       Microsoft.PowerToys                           0.58.0          0.61.1
Python 3                  Python.Python.3                               3.10.3          3.10.6
```

Get upgrades with a name that begins with P.

### Example 3

```powershell
PS C:\> Get-WGUpgrade -id micro* | Select-Object Name,Version,Available

Name                                                 Version       Available
----                                                 -------       ---------
Visual Studio Community 2019                         16.11.10      16.11.17
Microsoft Visual C++ 2015-2022 Redistributable (x86) 14.31.31103.0 14.32.31332.0
Microsoft .NET SDK 3.1                               3.1.419       3.1.421
PowerToys (Preview)                                  0.58.0        0.61.1
Microsoft Visual C++ 2015-2022 Redistributable (x86) 14.32.31326.0 14.32.31332.0

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

### wingetUpgrade

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Invoke-WGUpgrade](Invoke-WGUpgrade.md)

[Get-WGInstalled](Get-WGInstalled.md)
