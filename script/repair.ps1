sfc /scannow
chkdsk /f /r
wsreset.exe
dism /Online /CheckHealth
dism /Online /ScanHealth
dism /Online /Cleanup-Image /RestoreHealth
