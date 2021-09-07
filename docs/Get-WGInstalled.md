---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version:
schema: 2.0.0
---

# Get-WGInstalled

## SYNOPSIS

Get packages installed with winget.

## SYNTAX

```yaml
Get-WGInstalled [[-Source] <String>] [<CommonParameters>]
```

## DESCRIPTION

This command will get a list of all packages installed with winget. These will be packages with winget as the source. This command will have to be revised once more sources are available.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-WGInstalled
Name             ID                Version      Description
----             --                -------      -----------
Foxit PDF Reader Foxit.FoxitReader 11.0.0.49893 Foxit is a powerful PDF reader
                                                for viewing, filling out forms
                                                and more.
...
```

## PARAMETERS

### -Source

Specify a winget source. Currently, there is really only a single source but this might eventually change.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: winget
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### wgPackage

## NOTES

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/learn

## RELATED LINKS

[Get-WGPackage](Get-WGPackage.md)
