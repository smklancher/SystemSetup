# Description: Boxstarter Script, originally based on https://github.com/microsoft/windows-dev-box-setup-scripts/blob/master/dev_app_desktop_.NET.ps1
# Author: Microsoft
# Common dev settings for desktop app development

Disable-UAC
# mention of this not working in later versions: https://superuser.com/a/1047031/137746
Set-MpPreference -DisableRealtimeMonitoring $true

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$baseUri = $helperUri
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

# install git and clone the whole repo
choco install -y git --package-parameters='"/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration"'
refreshenv
git clone https://github.com/smklancher/SystemSetup.git C:\Temp\SystemSetup

#--- Windows components ---
executeScript "WindowsComponent-IIS.ps1";

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";

#--- Local Computer Policy
$lgpodir="C:\Temp\LGPO"
$lgpo="$lgpodir\lgpo.exe"
$lgpotxt="$lgpodir\LocalGroupPolicy.txt"
New-Item -ItemType Directory -Force -Path $lgpodir | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
(new-object net.webclient).DownloadFile("$baseUri/lgpo/LGPO.exe",$lgpo)
(new-object net.webclient).DownloadFile("$baseUri/lgpo/LocalGroupPolicy.txt",$lgpotxt)
Start-Process -FilePath $lgpo -ArgumentList "/t",$lgpotxt -WorkingDirectory $lgpodir -RedirectStandardOutput "Output.txt" -RedirectStandardError "Error.txt"



executeScript "Browsers.ps1";

# install .NET 4.8 (remove --pre once package is updated): https://chocolatey.org/packages/dotnetfx
choco install -y dotnetfx --pre
choco install -y 7zip.install
choco install -y sysinternals
choco install -y notepadplusplus.install
choco install -y sumatrapdf.install
choco install -y spacesniffer

choco install -y silverlight
choco install -y fiddler4
choco install -y irfanview

choco install -y sql-server-management-studio
choco install -y dotpeek
choco install -y tortoisegit

executeScript "VisualStudio.ps1";

# file structure to explicitly copy to C:\
xcopy C:\Temp\SystemSetup\copy\* C:\ /E /C /H /R /Y

# misc - file extensions, taskbar pins, etc
C:\Temp\SystemSetup\misc\RunMisc.cmd

#--- reenabling critial items ---
# Enable-UAC
Set-MpPreference -DisableRealtimeMonitoring $false
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula


# agentransack requires manual input
choco install -y agentransack

# classic shell only for Windows 2012
# choco install -y classic-shell
