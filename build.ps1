param(
    [string]$OutputDirectory = (Join-Path $PSScriptRoot '../MNX_Builds/ext.gui.image.webp/win-x64')
)

$ErrorActionPreference = 'Stop'
$publishDirectory = Join-Path $PSScriptRoot 'bin/publish/win-x64'
$project = Join-Path $PSScriptRoot 'ext.gui.image.webp.csproj'

dotnet publish $project -c Release -r win-x64 -o $publishDirectory -p:UseSharedCompilation=false
if ($LASTEXITCODE -ne 0) {
    throw 'NativeAOT publish failed.'
}

# Only the plugin is distributed; MNXArchiver supplies the SkiaSharp native library.
New-Item -ItemType Directory -Force -Path $OutputDirectory | Out-Null
Copy-Item (Join-Path $publishDirectory 'ext.gui.image.webp.mnxp') $OutputDirectory -Force
Write-Output "Built $(Join-Path $OutputDirectory 'ext.gui.image.webp.mnxp')"
