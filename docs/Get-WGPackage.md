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

This command is a PowerShell wrapper around winget.cmd that will get a package and create an object you can use in PowerShell.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-WGPackage -name "Foxit PDF Reader"

Name                      ID                             Version         Description
----                      --                             -------         -----------
Foxit PDF Reader          Foxit.FoxitReader         12.0.1.12430         Foxit is a powerful PDF reader for viewing, filling out forms and more.
```

Get a package by its name.

### Example 2

```powershell
PS C:\> Get-WGPackage -id "Microsoft.Powershell.Preview" | Select-Object *

Moniker             : pwsh-preview
Description         : PowerShell is a cross-platform Windows, Linux, and macOS
                      automation and configuration tool/frame work that works
                      well with your existing tools and is optimized for
                      dealing with structured data e.g. JSON, CSV, XML, etc.,
                      REST APIs, and object models.
Author              : Microsoft Corporation
Publisher           : Microsoft Corporation
PublisherUrl        : https://github.com/PowerShell/PowerShell
PublisherSupportUrl : https://github.com/PowerShell/PowerShell/issues
Homepage            : https://microsoft.com/PowerShell
Name                : PowerShell Preview
ID                  : Microsoft.PowerShell.Preview
Version             : 7.3.7.0
Source              : winget
Computername        : WIN11DESK
```

The output is a rich object.

### Example 3

```powershell
PS C:\> winget search --tag powerbi | Get-WGPackage | Select-Object Name,ID,Version


Name                      ID                  Version
----                      --                  -------
Microsoft PowerBI Desktop Microsoft.PowerBI   2.109.642.0
DAX Studio                DaxStudio.DaxStudio 3.0.0.725
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
