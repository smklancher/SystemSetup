# Functions here rely on being imported into the main script to use $localPath etc
if ($null -eq $localPath){
	$localPath = "C:\Temp\SystemSetup"
}

function Import-LocalGroupPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]
        $Name
    )
    
    $lgpodir="$localPath\LGPO"
    $lgpo="$lgpodir\lgpo.exe"
    $lgpotxt="$lgpodir\$Name.txt"
    Start-Process -FilePath $lgpo -ArgumentList "/t",$lgpotxt -WorkingDirectory $lgpodir -RedirectStandardOutput "$lgpodir\$Name-Output.txt" -RedirectStandardError "$lgpodir\$Name-Error.txt"
}

function Get-LatestGithubReleaseUsingGlare {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $GitHubUser
    )
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        [string] $GitHubRepo
    )
    param (
        [Parameter(Mandatory = $true, Position = 2)]
        [string] $AssetRegex
    )
    
    
    # Should probably switch to Invoke-WebRequest
    # Enable TLS 1.2 
    #[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    # git install should add curl to path, but powershell has an alias that redirects to Invoke-WebRequest, so add ".exe" to force real curl
    & "curl.exe -fLO https://glare.now.sh/$GithubUser/$GithubRepo/$AssetRegex"
}

function FinalSteps {
    # file structure to explicitly copy to C:\
    xcopy "$localPath\copy\*" C:\ /E /C /H /R /Y

    # misc - file extensions, taskbar pins, etc
    & "$localPath\misc\RunMisc.cmd"

    #--- reenabling critial items ---
    # Enable-UAC
    Set-MpPreference -DisableRealtimeMonitoring $false
    Enable-MicrosoftUpdate
    Install-WindowsUpdate -acceptEula
}
