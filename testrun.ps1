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
choco uninstall myApp
cinst myApp -source C:\Temp\TestPackage -y --package-parameters="/SimpleDoubleQuote /WindowsTerminal /NoShellIntegration"
cinst myApp -source C:\Temp\TestPackage -y --package-parameters="'/DoubleSingle /WindowsTerminal /NoShellIntegration'"
cinst myApp -source C:\Temp\TestPackage -y --package-parameters="`"/BacktickEscapedDouble /WindowsTerminal /NoShellIntegration`""
cinst myApp -source C:\Temp\TestPackage -y --package-parameters="""/DoubleEscapedDouble /WindowsTerminal /NoShellIntegration"""
cinst myApp -source C:\Temp\TestPackage -y --package-parameters='"/SingleDouble /WindowsTerminal /NoShellIntegration"'
cinst myApp -source C:\Temp\TestPackage -y --package-parameters='/Single /WindowsTerminal /NoShellIntegration'
cinst myApp -source C:\Temp\TestPackage -y --package-parameters='''/SingleEscapedSingle /WindowsTerminal /NoShellIntegration'''
#cinst myApp -source C:\Temp\TestPackage -y --package-parameters='`'/BacktickEscapedSingle /WindowsTerminal /NoShellIntegration`''