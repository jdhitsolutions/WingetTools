
#region Main

Get-ChildItem -path $PSScriptroot\functions\*.ps1 |
ForEach-Object { . $_.Fullname}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#endregion


