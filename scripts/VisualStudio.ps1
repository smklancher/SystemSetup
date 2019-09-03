#--- Installing VS and VS Code with Git
# See this for install args: https://chocolatey.org/packages/VisualStudio2019Professional
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-id

choco install visualstudio2019professional --package-parameters="'--passive --add Microsoft.VisualStudio.Component.Git --add Component.GitHub.VisualStudio'" -y --cacheLocation $ChocoCachePath
Update-SessionEnvironment #refreshing env due to Git install

choco install visualstudio2019-workload-manageddesktop --package-parameters="'--passive --add Microsoft.VisualStudio.Component.NuGet'" -y --cacheLocation $ChocoCachePath

# Not working, so create local package: https://github.com/chocolatey/choco/issues/1201#issuecomment-389299782
# Install-VisualStudioVsixExtension -PackageName "CodeMaid" -VsixUrl https://stevecadwallader.gallerycdn.vsassets.io/extensions/stevecadwallader/codemaid/11.0.183/1553341607616/CodeMaid_v11.0.183.vsix

# dependent on parent script cloning repo to temp
choco install CodeMaidVsix -source "$localPackages\CodeMaidVsix" -y --cacheLocation $ChocoCachePath