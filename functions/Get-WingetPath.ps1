function Get-WingetPath {
$currentUser = whoami # get account running function
	if ($currentUser -eq "nt authority\system")
	{
	# check if running in SYSTEM context set path to WINGET executable
	$winget = gci "C:\Program Files\WindowsApps" -Recurse -File | where { $_.name -like "AppInstallerCLI.exe" -or $_.name -like "WinGet.exe" } | select -ExpandProperty fullname
	# If there are multiple versions, select latest
	if ($winget.count -gt 1) { $winget = $winget[-1] }
	}
	else { $winget = "$env:localappdata\Microsoft\WindowsApps\Winget.exe" }
    return $winget
}