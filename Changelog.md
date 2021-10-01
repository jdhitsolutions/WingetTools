# Changelog for WingetTools

## v0.6.0

+ Update `Install-Winget` to allow installing latest stable or preview build.
+ Update `Get-WGReleaseNote` to allow getting latest stable or preview release note.
+ Updated help documentation.

## v0.5.1

+ Revised `Install-Winget` to better test for the VCLibs requirement.
+ Updated help documentation.

## v0.5.0

+ Revised `Install-Winget` to download the VCLib requirement and then install it instead of relying on `Add-AppxPackage` and a URL path which doesn't always work.

## v0.4.0

+ Modified manifest to only export `Install-Winget` in Windows PowerShell sessions.
+ Added online help links.
+ Updated `README.md`.
+ First public release.

## v0.3.0

+ Added `Get-WGInstalled` to list winget installed packages.
+ Added `Source` parameter to `Get-WGInstalled` and `Get-WGPackage`.
+ Updated `README.md`.
+ Update about help topic.

## v0.2.0

+ Added parameter to `Get-WGPackage` to accept winget output.
+ Created external help documentation.

## v0.1.0

+ initial module.
