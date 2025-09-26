@echo off

echo Checking for health and repairs...
sfc /scannow
chkdsk /f /r
wsreset.exe
dism /Online /CheckHealth
dism /Online /ScanHealth
dism /Online /Cleanup-Image /RestoreHealth

echo Clearing cache, temporary files and logs...
echo Btw, do this only when you experience slowdowns. Avoid doing this more than once within a week
