# Description: Boxstarter Script, originally based on https://github.com/microsoft/windows-dev-box-setup-scripts/blob/master/dev_app_desktop_.NET.ps1


# Start common section: install git and copy everything else locally
    #Disable-UAC
    # mention of this not working in later versions: https://superuser.com/a/1047031/137746
    #Set-MpPreference -DisableRealtimeMonitoring $true

    $localPath = "C:\Temp\SystemSetup"

   

    # recursive cache folder issue: https://github.com/chocolatey/boxstarter/issues/241
    $ChocoCachePath = "C:\Temp\Chocolatey"
    New-Item -Path $ChocoCachePath -ItemType directory -Force
    choco feature enable -n=useRememberedArgumentsForUpgrades

    $localScripts = "$localPath\scripts"
    $localPackages = "$localPath\LocalPackages"
    . "$localScripts\CommonFunctions.ps1"
# End common section: now call everything from $localPath




#--- Windows components ---
#. "$localScripts\WindowsComponent-IIS.ps1";

#--- Setting up Windows ---
#. "$localScripts\FileExplorerSettings.ps1";
#. "$localScripts\RemoveDefaultApps.ps1";

#--- Local Computer Policy
Import-LocalGroupPolicy "LocalGroupPolicy"
Import-LocalGroupPolicy "WindowsUpdateOnSunday"



#--- Browsers ---
# --ignorechecksum is not ideal but prevents failure between chrome release and package approval
choco install googlechrome -y --ignorechecksum --cacheLocation $ChocoCachePath
# useful to have ublock even on VMs where I'm not signing into chrome
choco install ublockorigin-chrome -y --cacheLocation $ChocoCachePath
choco install firefox -y --cacheLocation $ChocoCachePath


choco install dotnetfx -y --cacheLocation $ChocoCachePath
choco install 7zip.install -y --cacheLocation $ChocoCachePath
choco install sysinternals -y --cacheLocation $ChocoCachePath
choco install notepadplusplus.install -y --cacheLocation $ChocoCachePath
choco install sumatrapdf.install -y --cacheLocation $ChocoCachePath
choco install spacesniffer -y --cacheLocation $ChocoCachePath
choco install processhacker.install -y --cacheLocation $ChocoCachePath

choco install silverlight -y --cacheLocation $ChocoCachePath
choco install fiddler4 -y --cacheLocation $ChocoCachePath
choco install irfanview -y --cacheLocation $ChocoCachePath
choco install exiftool -y --cacheLocation $ChocoCachePath

choco install sql-server-management-studio -y --cacheLocation $ChocoCachePath
choco install dotpeek -y --cacheLocation $ChocoCachePath

. "$localScripts\VisualStudio.ps1";

#--- Main Systems ---
choco install greenshot -y --cacheLocation $ChocoCachePath
choco install lastpass -y --cacheLocation $ChocoCachePath
choco install lastpass-for-applications -y --cacheLocation $ChocoCachePath
choco install lux -y --cacheLocation $ChocoCachePath
choco install f.lux.install -y --cacheLocation $ChocoCachePath
choco install terminals -y --cacheLocation $ChocoCachePath
choco install adb -y --cacheLocation $ChocoCachePath
choco install trillian -y --cacheLocation $ChocoCachePath
choco install google-backup-and-sync -y --cacheLocation $ChocoCachePath
choco install filezilla -y --cacheLocation $ChocoCachePath
choco install rescuetime -y --cacheLocation $ChocoCachePath
choco install winhue -y --cacheLocation $ChocoCachePath
choco install mpc-hc-clsid2 -y --cacheLocation $ChocoCachePath
choco install devcon.portable -y --cacheLocation $ChocoCachePath



#--- Gaming ---
choco install steam -y --cacheLocation $ChocoCachePath
# remove version once approved: https://chocolatey.org/packages/battle.net/1.16.3.2988
#choco install -y battle.net --version 1.16.3.2988

# Battle.Net / Hearthstone
# Obstacles with Battle.Net package because reasons: 
# https://chocolatey.org/packages/battle.net/1.16.3.2988
# https://github.com/chocolatey/choco/issues/1888
# So, install from local package
choco install autohotkey.install -y --cacheLocation $ChocoCachePath
choco install battle.net -source "$localPackages\Battle.Net" -y --cacheLocation $ChocoCachePath --ignorechecksum
# Then remove the package without uninstalling, because it will auto update anyway
choco uninstall battle.net -n --skipautouninstaller
# Then start Hearthstone install (example game names: https://us.battle.net/forums/en/bnet/topic/20752501530)
# Actually, can't install until after login
#"C:\Program Files (x86)\Battle.net\battle.net.exe --game=hs_beta --install"
# HDT package is outdated and looks like it fails to auto update from that version
# choco install hearthstone-deck-tracker -y --cacheLocation $ChocoCachePath

# Download installers to be run manually where possible
$toBeRun="$localPath\ManualInstalls"
New-Item -Path $toBeRun -ItemType directory -Force

Set-Location $toBeRun
Get-LatestGithubReleaseUsingGlare -GitHubUser "HearthSim" -GitHubRepo "HDT-Releases" -AssetRegex "exe"

#--- Maybe ---
#choco install -y auto-dark-mode
##choco install -y skypeforbusiness
#choco install -y silverlight
# sounds like the agentransack package has issues
#choco install -y agentransack
# better to go with this: https://github.com/Bioruebe/UniExtract2
#choco install -y uniextract
#choco install drobo-dashboard -y --cacheLocation $ChocoCachePath
# consider: https://chocolatey.org/packages?q=logitech


FinalSteps


# agentransack requires manual input
#choco install agentransack -y --cacheLocation $ChocoCachePath

# classic shell only for Windows 2012
# choco install -y classic-shell
