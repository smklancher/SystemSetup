
function Import-LocalGroupPolicy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
                   Position = 0)]
        [string]
        $Name
    )
    
    $lgpodir="$localPath\LGPO"
    $lgpo="$lgpodir\lgpo.exe"
    $lgpotxt="$lgpodir\$Name.txt"
    Start-Process -FilePath $lgpo -ArgumentList "/t",$lgpotxt -WorkingDirectory $lgpodir -RedirectStandardOutput "$lgpodir\$Name-Output.txt" -RedirectStandardError "$lgpodir\$Name-Error.txt"
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
