
#region Main

Get-ChildItem -path $PSScriptroot\functions\*.ps1 |
ForEach-Object { . $_.Fullname}

#endregion


