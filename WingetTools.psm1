#region define a class

class wingetUpgrade {
    [string]$Name
    [string]$ID
    [string]$Version
    [string]$Available
    [string]$Source = "winget"
    [string]$Computername = $env:COMPUTERNAME

    wingetUpgrade($Name, $ID, $version, $available) {
        $this.name = $Name
        $this.ID = $ID
        $this.version = $version
        $this.available = $available
    }
}

#region Main

Get-ChildItem -Path $PSScriptroot\functions\*.ps1 |
ForEach-Object { . $_.Fullname }

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#endregion


