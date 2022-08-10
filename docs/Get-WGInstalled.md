---
external help file: WingetTools-help.xml
Module Name: WingetTools
online version: https://bit.ly/38Ps9nb
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
PS C:\> Get-WGInstalled -outvariable in

Name                      ID                        Version             Description
----                      --                        -------             -----------
Visual Studio Community   Microsoft.VisualStudio.20 16.11.10            The Community edition of Visual Studio, an
2019                      19.Community                                  integrated development environment (IDE) from
                                                                        Microsoft.  Individual developers have no
                                                                        restrictions on their use of the Community
                                                                        edition.
Audacity                  Audacity.Audacity         3.1.3               Audacity is a free, easy-to-use, multi-track
                                                                        audio editor and recorder for Windows, macOS,
                                                                        GNU/Linux and other operating systems.
Ubuntu                    Canonical.Ubuntu          2004.2021.825.0     Ubuntu on Windows allows you to use Ubuntu
                                                                        Terminal and run Ubuntu command line
                                                                        utilities including bash, ssh, git, apt and
                                                                        many more. This is the latest LTS release.
CCleaner                  Piriform.CCleaner         6.00                CCleaner is a utility used to clean
                                                                        potentially unwanted files and invalid
                                                                        Windows Registry entries from a computer.
...
```

Because of the processing overhead, it is recommended that you save results to a variable.

### Example 2

```powershell
PS C\>  $in | format-table -view update

ID                                          InstalledVersion     OnlineVersion        Update
--                                          ----------------     -------------        ------
Microsoft.VisualStudio.2019.Community       16.11.10             16.11.17             True
Audacity.Audacity                           3.1.3                3.1.3                False
Piriform.CCleaner                           6.00                 6.01                 True
Canonical.Ubuntu                            2004.2021.825.0      2004.2021.825.0      False
Discord.Discord                             1.0.9003             1.0.9005             True
Foxit.FoxitReader                           12.0.0.12394         12.0.1.12430         True
Git.Git                                     2.37.1               2.37.1               False
```

There is named table view you can use to quickly identify potential updates.

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

[Get-WGUpgrade](Get-WGUpgrade.md)
