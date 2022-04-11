---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/3jQh9MH
schema: 2.0.0
---

# Get-WGPackage

## SYNOPSIS

Get information about a winget package

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

This command is a PowerShell wrapper aroung winget.cmd that will get a package and create an object you can use in PowerShell. The

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

Get a package by its name.

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

The output is a rich object.

### Example 3

```powershell
PS C:\> winget search --tag powerbi | get-wgpackage | Select-Object Name,ID,Version


Name                      ID                  Version
----                      --                  -------
DAX Studio                DaxStudio.DaxStudio 2.17.3.683
Microsoft PowerBI Desktop Microsoft.PowerBI   2.102.845.0
```

You can pipe the results of a winget search command to this function.

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

Pipe a winget search to this function.

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

Specify the winget moniker.

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

Specify the winget package name.

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

Specify a winget source. Currently, there is really only a single source but this might eventually change.

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
