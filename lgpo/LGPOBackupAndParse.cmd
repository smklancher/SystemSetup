cd /d %~dp0
lgpo /b %cd% /n "Backup"
@echo Copy Machine and User folders into ToBeParsed...
pause
lgpo /parse /m .\ToBeParsed\Machine\registry.pol > lgpo.txt
lgpo /parse /u .\ToBeParsed\User\registry.pol >> lgpo.txt
pause