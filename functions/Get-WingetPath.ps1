Function Get-WGPath {
    [cmdletbinding()]
    [OutputType("String")]
    Param()
    Write-Verbose "[$((Get-Date).TimeofDay)] Starting $($myinvocation.mycommand)"
    $currentUser = whoami # get account running function
    Write-Verbose "[$((Get-Date).TimeofDay)] Running as $currentUser"
    if ($currentUser -eq "nt authority\system") {
        Write-Verbose "[$((Get-Date).TimeofDay)] Running in SYSTEM context. Set path to WINGET executable"
        $winget = Get-ChildItem -Path "$env:ProgramFiles\WindowsApps" -Recurse -File | Where-Object { $_.name -like "AppInstallerCLI.exe" -or $_.name -like "WinGet.exe" } | Select-Object -ExpandProperty fullname
        # If there are multiple versions, select latest
        if ($winget.count -gt 1) {
            $winget = $winget[-1]
        }
    }
    else {
        Write-Verbose "[$((Get-Date).TimeofDay)] Using user default location"
        $winget = "$env:localappdata\Microsoft\WindowsApps\Winget.exe"
     }
    $winget
    Write-Verbose "[$((Get-Date).TimeofDay)] Ending $($myinvocation.mycommand)"
}