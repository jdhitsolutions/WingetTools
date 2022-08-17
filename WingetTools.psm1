#region define a class

Class wgBase {
    [string]$Name
    [string]$ID
    [string]$Version
    [string]$Source = "winget"
    [string]$Computername = $env:COMPUTERNAME
}

Class wgPackage:wgBase {
    [string]$Moniker
    [string]$Description
    [string]$Author
    [string]$Publisher
    [string]$PublisherUrl
    [string]$PublisherSupportUrl
    [string]$Homepage
}

Class wgInstalled:wgPackage {
    [string]$InstalledVersion
}

class wgUpgrade:wgBase {
    [string]$Available
    [string]$Source = "winget"

    wgUpgrade($Name, $ID, $version, $available) {
        $this.name = $Name
        $this.ID = $ID
        $this.version = $version
        $this.available = $available
    }
}

Update-TypeData -TypeName wgInstalled -MemberType AliasProperty -MemberName OnlineVersion -Value Version -force

#region Main

Get-ChildItem -Path $PSScriptroot\functions\*.ps1 |
ForEach-Object { . $_.Fullname }

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#endregion

#load localized data
Try {
    Import-LocalizedData -BindingVariable localized -FileName localized.psd1 -ErrorAction Stop

    # write-host "Imported localized data for $(Get-Culture)" -ForegroundColor green
    # $localized | out-string | write-host -ForegroundColor green
}
Catch {
    Import-LocalizedData -BindingVariable localized -FileName localized.psd1 -UICulture en-US
}

