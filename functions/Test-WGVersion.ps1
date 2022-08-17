

Function Test-WGVersion {
    [cmdletbinding()]
    [OutputType("Boolean", "WGVersion")]
    Param(
        [Parameter(ValueFromPipeline)]
        [switch]$Quiet
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin

    Process {
        #not using Get-Appx package because it doesn't work in older versions of PowerShell 7
        [version]$local = (winget --version).replace("v", "")
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Found installed version $local"
        $note = Get-WGReleaseNote
        [version]$remote = $note.version.replace("v", "")

        if ($quiet) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting boolean result"
            $remote -gt $local
        }
        else {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting full result"
            [PSCustomObject]@{
                PSTypeName   = "WGVersion"
                Installed    = $local
                Online       = $remote
                Update       = $remote -gt $local
                Command      = (Get-Command winget).source
                Link         = $note.link
                ComputerName = $env:COMPUTERNAME
            }
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Test-WGVersion