function Get-WingetPath {
$currentUser = whoami # get account running function
	if ($currentUser -eq "nt authority\system")
	{
	# check if running in SYSTEM context set path to WINGET executable
	$winget = Get-ChildItem -path "$env:ProgramFiles\WindowsApps" -Recurse -File | where-object { $_.name -like "AppInstallerCLI.exe" -or $_.name -like "WinGet.exe" } | Select-Object -ExpandProperty fullname
	# If there are multiple versions, select latest
	if ($winget.count -gt 1) { $winget = $winget[-1] }
	}
	else { $winget = "$env:localappdata\Microsoft\WindowsApps\Winget.exe" }
    return $winget
}