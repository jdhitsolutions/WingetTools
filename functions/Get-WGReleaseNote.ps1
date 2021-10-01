Function Get-WGReleaseNote {
    [CmdletBinding()]
    [alias("wglatest")]
    [outputtype([System.String])]
    [outputtype("ReleaseNote")]
    Param(
        [Parameter(HelpMessage = "Create a markdown document.")]
        [alias("md")]
        [switch]$AsMarkdown,
        [switch]$Online,
        [Parameter(HelpMessage = "Get latest preview release")]
        [switch]$Preview
    )

    Write-Verbose "[$((Get-Date).TimeofDay)] Starting $($myinvocation.mycommand)"

    $uri = "https://api.github.com/repos/microsoft/winget-cli/releases"

    Try {
        Write-Verbose "[$((Get-Date).TimeofDay)] Getting information from $uri"
        $get = Invoke-RestMethod -uri $uri -Method Get -ErrorAction stop

        if ($Preview) {
            Write-Verbose "[$((Get-Date).TimeofDay)] Getting latest preview release"
            $data = $get | Where-Object {$_.PreRelease} | Select-Object -first 1
        }
        else {
            Write-Verbose "[$((Get-Date).TimeofDay)] Getting latest stable release"
            $data = $get | Where-Object {-not $_.PreRelease} | Select-Object -first 1

        }

        $data | Select-Object -Property Name, tag_name, published_at, prerelease,

        @{Name = "bodyLength"; Expression = {$_.body.length}} | Out-String | Write-Verbose

        if ($online) {
            Write-Verbose "[$((Get-Date).TimeofDay)] Opening $($data.html_url) in your web browser."
            Start-Process $data.html_url
        }
        elseif ($AsMarkdown) {
            Write-Verbose "[$((Get-Date).TimeofDay)] Creating a markdown document"
            $md = @"
# $($data.name)

> Version    : $($data.tag_name)
>
> Published   : $($data.published_at -as [datetime])
>
> Pre-Release : $($data.prerelease)

$($data.body.trim())

***

*Source: $($data.html_url)*
"@
            #write the object to the pipeline
            $md
        } #as markdown
        else {
            Write-Verbose "[$((Get-Date).TimeofDay)] Creating ReleaseNote"

            [pscustomobject]@{
                PSTypename = "ReleaseNote"
                Name       = $data.name
                Version    = $data.tag_name
                Published  = $($data.published_at -as [datetime])
                Prerelease = If ($data.prerelease -eq 'true') {$True} else {$false}
                Notes      = $data.body.trim()
            }
        }
    } #try
    Catch {
        Throw $_
    }
    Write-Verbose "[$((Get-Date).TimeofDay)] Ending $($myinvocation.mycommand)"
} #end function