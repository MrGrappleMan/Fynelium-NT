# Check for admin privileges
$isAdmin = ([System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Re-run with admin rights" -ForegroundColor Red
    Write-Host "Press Enter to exit"
    Read-Host
    exit
}

$services = @(
    "SensrSvc", "SensorService", "NetTcpPortSharing", "wisvc", "WpnUserService",
    "WpnService", "UserDataSvc", "UnistoreSvc", "UevAgentService", "UsoSvc",
    "InstallService", "DiagTrack", "tzautoupdate", "BITS", "DoSvc", "wuauserv",
    "WaaSMedicSvc", "Dnscache", "svsvc", "Winmgmt", "whesvc", "WebClient",
    "W32Time", "WlanSvc", "dot3svc", "SysMain", "WSearch", "PrintNotify",
    "Spooler", "Fax", "PrintWorkflowUserSvc", "StiSvc", "FrameServer", "WiaRpc"
)

foreach ($svcName in $services) {
    $service = Get-Service -Name $svcName -ErrorAction SilentlyContinue
    if ($service) {
        Set-Service -Name $svcName -StartupType Automatic -ErrorAction SilentlyContinue
    } else {
        Write-Host "Service $svcName not found." -ForegroundColor Yellow
    }
}
