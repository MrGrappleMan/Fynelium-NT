sfc /scannow
chkdsk /f /r
wsreset.exe
dism /Online /CheckHealth
dism /Online /ScanHealth
dism /Online /Cleanup-Image /RestoreHealth
w32tm /resync /rediscover
ipconfig /release
ipconfig /renew
ipconfig /release6
ipconfig /renew6
ipconfig /flushdns
ipconfig /registerdns
netsh winsock reset
netsh ip reset
Start-MpWDOScan
winget upgrade --all

Remove-Item -Path $env:windir\Temp -Recurse -Force
Remove-Item -Path $env:windir\Prefetch -Recurse -Force
Remove-Item -Path $env:SystemDrive\Windows.old -Recurse -Force
