#--- Installing VS and VS Code with Git
# See this for install args: https://chocolatey.org/packages/VisualStudio2019Professional
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-id

choco install -y visualstudio2019professional --package-parameters="'--passive --add Microsoft.VisualStudio.Component.Git --add Component.GitHub.VisualStudio'"
Update-SessionEnvironment #refreshing env due to Git install

#--- 
choco install -y visualstudio2019-workload-manageddesktop --package-parameters="'--passive --add Microsoft.VisualStudio.Component.NuGet'"

# Install-ChocolateyVsixPackage expects a registry setting that doesn't exist for VS2019
#Set-ItemProperty -Path HKLM:\SOFTWARE\WOW6432Node\Microsoft\VisualStudio\16.0 -Name InstallDir -Value "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE"
#Install-ChocolateyVsixPackage -PackageName "CodeMaid" -VsixUrl https://stevecadwallader.gallerycdn.vsassets.io/extensions/stevecadwallader/codemaid/11.0.183/1553341607616/CodeMaid_v11.0.183.vsix

# Might need to do something else to make this work: https://github.com/chocolatey/choco/issues/1201#issuecomment-389299782
Install-VisualStudioVsixExtension -PackageName "CodeMaid" -VsixUrl https://stevecadwallader.gallerycdn.vsassets.io/extensions/stevecadwallader/codemaid/11.0.183/1553341607616/CodeMaid_v11.0.183.vsix