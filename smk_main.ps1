# Description: Boxstarter Script, originally based on https://github.com/microsoft/windows-dev-box-setup-scripts/blob/master/dev_app_desktop_.NET.ps1
# Author: Microsoft
# Common dev settings for desktop app development

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Windows components ---
choco install -y IIS-WebServerRole -source windowsfeatures
choco install -y NetFx3 -source windowsFeatures
choco install -y WCF-HTTP-Activation45 -source windowsFeatures
choco install -y WCF-HTTP-Activation -source windowsFeatures
choco install -y IIS-WindowsAuthentication -source windowsFeatures

#--- Setting up Windows ---
executeScript "FileExplorerSettings.ps1";
executeScript "RemoveDefaultApps.ps1";


choco install -y GoogleChrome
# useful to have ublock even on VMs where I'm not signing into chrome
choco install -y ublockorigin-chrome
choco install -y firefox

# install .NET 4.8 (remove --pre once package is updated): https://chocolatey.org/packages/dotnetfx
choco install -y dotnetfx --pre
choco install -y 7zip.install
choco install -y sysinternals
choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration'"
choco install -y fiddler4
choco install -y notepadplusplus.install
choco install -y classic-shell
choco install -y irfanview
choco install -y sumatrapdf.install
choco install -y sql-server-management-studio
choco install -y dotpeek
choco install -y tortoisegit
choco install -y spacesniffer


executeScript "VisualStudio.ps1";

#--- Main Systems ---
choco install -y greenshot
choco install -y lastpass
choco install -y lastpass-for-applications
choco install -y lux
choco install -y f.lux.install
choco install -y terminals
choco install -y adb
choco install -y trillian
choco install -y google-backup-and-sync
choco install -y filezilla
choco install -y rescuetime
choco install -y winhue

#--- Gaming ---
choco install -y steam
# remove version once approved: https://chocolatey.org/packages/battle.net/1.16.3.2988
choco install -y battle.net --version 1.16.3.2988
choco install -y hearthstone-deck-tracker

#--- Maybe ---
choco install -y auto-dark-mode
choco install -y skypeforbusiness
choco install -y silverlight
# sounds like the agentransack package has issues
choco install -y agentransack
# better to go with this: https://github.com/Bioruebe/UniExtract2
choco install -y uniextract



#--- reenabling critial items ---
# Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
