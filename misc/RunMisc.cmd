cd /d %~dp0

PinToTaskbar\syspin "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\devenv.exe" "Unpin from taskbar"
PinToTaskbar\syspin "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\devenv.exe" "Pin to taskbar"

REM Browser default and pin
SetDefaultBrowser\SetDefaultBrowser chrome
PinToTaskbar\syspin "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "Unpin from taskbar"
PinToTaskbar\syspin "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "Pin to taskbar"

REM Notepad++ plugins, associations, pin
PinToTaskbar\syspin "C:\Program Files\Notepad++\notepad++.exe" "Unpin from taskbar"
PinToTaskbar\syspin "C:\Program Files\Notepad++\notepad++.exe" "Pin to taskbar"
ftype inifile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
ftype inffile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
ftype txtfile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
ftype xmlfile="C:\Program Files\Notepad++\notepad++.exe" "%%1"
ftype Microsoft.PowerShellScript.1="C:\Program Files\Notepad++\notepad++.exe" "%%1"
SetUserFTA\SetUserFTA .txt txtfile  
SetUserFTA\SetUserFTA .log txtfile  
SetUserFTA\SetUserFTA .config txtfile  
SetUserFTA\SetUserFTA .xml xmlfile  

REM 7zip
ftype 7zip="C:\Program Files\7-Zip\7zFM.exe" "%%1"
SetUserFTA\SetUserFTA .zip 7zip
SetUserFTA\SetUserFTA .7z 7zip
SetUserFTA\SetUserFTA .rar 7zip
SetUserFTA\SetUserFTA .cab 7zip
SetUserFTA\SetUserFTA .iso 7zip
SetUserFTA\SetUserFTA .001 7zip

REM video
ftype Video="C:\Program Files\MPC-HC\mpc-hc64.exe" "%%1"
SetUserFTA\SetUserFTA .mp4 Video
SetUserFTA\SetUserFTA .avi Video
SetUserFTA\SetUserFTA .mp4 Video
SetUserFTA\SetUserFTA .3gp Video
SetUserFTA\SetUserFTA .mpeg Video
SetUserFTA\SetUserFTA .mpg Video
SetUserFTA\SetUserFTA .ogm Video
SetUserFTA\SetUserFTA .webm Video
SetUserFTA\SetUserFTA .wm Video
SetUserFTA\SetUserFTA .wmv Video

REM Remove folders
reg import "Registry\Remove Certain Folders\This PC - Remove 3D Objects 64-bit.reg"
reg import "Registry\Remove Certain Folders\This PC - Remove Desktop 64-bit.reg"
reg import "Registry\Remove Certain Folders\This PC - Remove Music 64-bit.reg"
reg import "Registry\Remove Certain Folders\This PC - Remove Videos 64-bit.reg"
reg import "Registry\Remove_User_Folder_from_Navigation_Pane.reg"