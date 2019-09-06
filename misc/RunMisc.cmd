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