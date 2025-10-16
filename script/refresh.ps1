# Serves as a form of shotgun debugging without resetting your system

sfc /scannow
chkdsk /f /r
wsreset.exe
dism /Online /CheckHealth
dism /Online /ScanHealth
dism /Online /Cleanup-Image /RestoreHealth
w32tm /resync /rediscover # NTP refresh
ipconfig /release
ipconfig /renew
ipconfig /release6
ipconfig /renew6
ipconfig /flushdns
ipconfig /registerdns
netsh winsock reset # Should remove later
netsh ip reset
winget upgrade --all # Helps with updating system packages

Remove-Item -Path $env:windir\Temp -Recurse -Force
Remove-Item -Path $env:windir\Prefetch -Recurse -Force
Remove-Item -Path $env:SystemDrive\Windows.old -Recurse -Force

Start-MpWDOScan # Restarts the device for Defender offline scan
