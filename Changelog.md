# Changelog for WingetTools

## v1.6.0

- Added missing online help links.
- Added localized data for `fr-FR`. This needs to be validated by someone running this culture as I'm not sure exactly what Winget will return.
- Modified code to filter out extended ASCII characters when parsing YAML content.
- Merged [PR #10](https://github.com/jdhitsolutions/WingetTools/pull/10) Thank you @Zephyrusg.
- Modified conversion code to strip out Release Notes since that section often causes yaml conversion problems and it isn't being used.
- Updated help.
- Updated `README.md`.

## v1.5.0

- Revised `Get-WGInstalled` to better handle non-English culture. [Issue #8](https://github.com/jdhitsolutions/WingetTools/issues/8)
- Renamed `Get-WingetPath` to `Get-WGPath`.
- Added a requirement for the `psyml` PowerShell module.
- Added cultural localization for DE-DE to parse `winget` output.
- Added help documention for de-DE.
- Defined custom objects as PowerShell classes.
- Renamed `wginstalled` property set to `versioninfo`.
- Added default list formats for `wginstall` and `wgpackage` types.
- Updated help.
- Updated `README.md`.

## v1.4.1

- Update module to support running in SYSTEM context. [Pull request #7](https://github.com/jdhitsolutions/WingetTools/pull/7)

## v1.4.0

- Added new parameters to `Invoke-WGUpgrade` [Issue #6](https://github.com/jdhitsolutions/WingetTools/issues/6)
- Major rewrite to `Get-WGInstalled`. Removed `Write-Progress` for better performance. Moved to using ThreadJobs to get online information in the background. Created a new object type, `WGInstalled`. **This could be a breaking change.**
- Major rewrite to `Get-WGUpgrade`. **This could be a breaking change.**
- Added `ThreadJob` as a required dependency.
- Added a `Computername` property to output objects that reflect local installations.
- Added types file `wginstalled.types.ps1xml`.
- Added format file `wginstalled.format.ps1xml`.
- Revised format file `wingetupgrade.format.ps1xml`
- Updated `README.md`.
- Help updates.

## v1.3.0

- Revised private functions used by `Get-WGPackage` that weren't parsing publisher data properly. [Issue #5](https://github.com/jdhitsolutions/WingetTools/issues/5)
- Updated `README.md`.
- Help updates.

## v1.2.0

- Revised regex pattern in `Get-WGUpgrade` that wasn't parsing data properly. This is most likely the fix for [Issue #3](https://github.com/jdhitsolutions/WingetTools/issues/3) and [Issue #4](https://github.com/jdhitsolutions/WingetTools/issues/4).
- Updated `README.md`.
- Help updates.

## v1.1.1

- Fixed bug in `Get-WGUpgrade` that wasn't parsing data properly. [Issue #3](https://github.com/jdhitsolutions/WingetTools/issues/3)
- Updated  `README.md`.
- Help updates.

## v1.1.0

- Fixed bug in `Get-WGPackage` to better handle non-English systems. [Issue #1](https://github.com/jdhitsolutions/WingetTools/issues/1)
- Improved parsing and regular expression matching to better process results. [Issue #2](https://github.com/jdhitsolutions/WingetTools/issues/2)
- help updates
- Minor updates to `README.md`.

## v1.0.0

- Fixed bug with `Get-WGUpgrade` that had bad formatting when running the command either first thing in the day, or when some sort of caching was getting cleared.
- Added command `Test-WGVersion` and format file `wgversion.format.ps1xml`.
- Updated `Get-WGReleaseNote` to include the online link.
- Modified the object typename for `Get-WGReleaseNote` to align it with other object names in this module. __*This is a breaking change.*__
- Updated help documentation.
- Updated `README.md`.

## v0.7.0

- Added `Get-WGUpgrade` and `Invoke-WGUpgrade`.
- Added format file `wingetupgrade.format.ps1xml`.
- Fixed package name typo in `Install-Winget`.
- Updated manifest to export all commands. PowerShell 7.2 now supports the Appx module which had been a blocker. **This is a breaking change.**
- Fixed bug in `Get-WGPackage` with the `Source` parameter.
- Updated help documentation.
- License update.
- Updated `README.md`.

## v0.6.0

- Update `Install-Winget` to allow installing latest stable or preview build.
- Update `Get-WGReleaseNote` to allow getting latest stable or preview release note.
- Updated help documentation.

## v0.5.1

- Revised `Install-Winget` to better test for the VCLibs requirement.
- Updated help documentation.

## v0.5.0

- Revised `Install-Winget` to download the VCLib requirement and then install it instead of relying on `Add-AppxPackage` and a URL path which doesn't always work.

## v0.4.0

- Modified manifest to only export `Install-Winget` in Windows PowerShell sessions.
- Added online help links.
- Updated `README.md`.
- First public release.

## v0.3.0

- Added `Get-WGInstalled` to list winget installed packages.
- Added `Source` parameter to `Get-WGInstalled` and `Get-WGPackage`.
- Updated `README.md`.
- Update about help topic.

## v0.2.0

- Added parameter to `Get-WGPackage` to accept winget output.
- Created external help documentation.

## v0.1.0

- initial module.
