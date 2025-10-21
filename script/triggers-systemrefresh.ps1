# Serves as a form of shotgun debugging without resetting your system
# Avoid running this

# Runs System File Checker to scan and repair corrupted system files
sfc /scannow

# Checks disk for errors and attempts to fix file system errors (/f) and bad sectors (/r)
chkdsk /f /r

# Resets the Windows Store cache to fix issues with the Microsoft Store
wsreset.exe

# Checks the health of the Windows Component Store for corruption
dism /Online /CheckHealth

# Performs a more thorough scan of the Windows Component Store for corruption
dism /Online /ScanHealth

# Repairs the Windows Component Store by restoring corrupted files from an online source
dism /Online /Cleanup-Image /RestoreHealth

# Forces the system to resynchronize the time with the Network Time Protocol (NTP) server and rediscover time sources
w32tm /resync /rediscover # NTP refresh

# Releases the current IPv4 address assigned to the system
ipconfig /release

# Requests a new IPv4 address from the DHCP server
ipconfig /renew

# Releases the current IPv6 address assigned to the system
ipconfig /release6

# Requests a new IPv6 address from the DHCP server
ipconfig /renew6

# Clears the DNS resolver cache to resolve DNS-related issues
ipconfig /flushdns

# Re-registers the system's DNS records with the DNS server
ipconfig /registerdns

# Resets the Windows Sockets API configuration to fix network connectivity issues
netsh winsock reset # Should remove later

# Resets the TCP/IP stack to its default configuration to fix network issues
netsh ip reset

# Deletes all files and folders in the Windows Temp directory to free up space and remove temporary files
Remove-Item -Path $env:windir\Temp -Recurse -Force

# Deletes all files and folders in the Windows Prefetch directory to clear cached application data
Remove-Item -Path $env:windir\Prefetch -Recurse -Force

# Initiates a Windows Defender Offline scan, which restarts the device to perform a deep malware scan
Start-MpWDOScan # Restarts the device for Defender offline scan
