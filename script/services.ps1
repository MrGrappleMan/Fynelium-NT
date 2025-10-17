# Check for admin privileges
$isAdmin = ([System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Re-run with admin rights" -ForegroundColor Red
    Write-Host "Press Enter to exit"
    Read-Host
    exit
}

# For winget, Windows Store, Windows updates, msix and appx installs. In a nutshell, package management
$updates = @(
    "UsoSvc",
    "wuauserv",
    "WaaSMedicSvc",
    "InstallService",
    "DoSvc"
)

# Reporting, data collection, analytics of various types
$telemetry = @(
    "DiagTrack",
    "wisvc"
)

# For handling data, drive management, backups, file management, indexing
$filesystem = @(
    "WSearch",
    "SysMain",
    "UnistoreSvc",
    "UserDataSvc"
)

# NTP, timezones
$time = @(
    "tzautoupdate",
    "W32Time"
)

# Proper establishment of connections
$networking = @(
    "NetTcpPortSharing",
    "Dnscache",
    "WlanSvc",
    "dot3svc",
    "WebClient"
)

# Generic, uncategorized
$services = @(
    "SensrSvc",
    "SensorService",
    "WpnUserService",
    "WpnService",
    "UevAgentService",
    "BITS",
    "svsvc",
    "Winmgmt",
    "whesvc",
    "PrintNotify",
    "Spooler",
    "Fax",
    "PrintWorkflowUserSvc",
    "StiSvc",
    "FrameServer",
    "WiaRpc"
)

foreach ($svcName in $services) {
    $service = Get-Service -Name $svcName -ErrorAction SilentlyContinue
    if ($service) {
        Set-Service -Name $svcName -StartupType Automatic -ErrorAction SilentlyContinue
    } else {
        Write-Host "Service $svcName not found." -ForegroundColor Yellow
    }
}
