$ErrorActionPreference = 'Continue'

Write-Host $MyInvocation.MyCommand.Definition

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

Write-Host (($pp.Keys | foreach { "$_ $($pp[$_])" }) -join "|")

$packageArgs = @{
    PackageName    = 'git.install'
    FileType       = 'exe'
    SoftwareName   = 'Git version *'
    File           = Get-Item $toolsPath\*-32-bit.exe
    File64         = Get-Item $toolsPath\*-64-bit.exe
    SilentArgs     = "/VERYSILENT", "/SUPPRESSMSGBOXES", "/NORESTART", "/NOCANCEL", "/SP-", "/LOG", (Get-InstallComponents $pp)
}

Write-Host $packageArgs.SilentArgs

# --package-parameters="/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration"