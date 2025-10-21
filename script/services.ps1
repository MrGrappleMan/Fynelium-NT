# Check for admin privileges
$isAdmin = ([System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Re-run with admin rights" -ForegroundColor Red
    Write-Host "Press Enter to exit"
    Read-Host
    exit
}

$updates = @(
    "A",
    "UsoSvc",
    "wuauserv",
    "WaaSMedicSvc",
    "InstallService",
    "DoSvc"
)

$telemetry = @(
    "B",
    "DiagTrack",
    "wisvc"
)

$filesystem = @(
    "B",
    "WSearch",
    "SysMain",
    "UnistoreSvc",
    "UserDataSvc"
)

$time = @(
    "A",
    "tzautoupdate",
    "W32Time"
)

$networking = @(
    "A",
    "NetTcpPortSharing",
    "Dnscache",
    "WlanSvc",
    "dot3svc",
    "WebClient"
)

$services = @(
    "B",
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

# Define service lists with A (Automatic) or B (Automatic Delayed Start) as the first element
# Function to process a list of lists and set service startup types
function Set-ServiceStartup {
    param($serviceLists)
    foreach ($list in $serviceLists) {
        if ($list.Count -lt 2) { continue } # Skip empty or invalid lists
        $startupType = if ($list[0] -eq "A") { "Automatic" } elseif ($list[0] -eq "B") { "AutomaticDelayedStart" } else { continue }
        foreach ($svcName in $list[1..($list.Count-1)]) {
            $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
            if ($svc) {
                Set-Service -Name $svcName -StartupType $startupType -ErrorAction SilentlyContinue
                Start-Service -Name $svcName -ErrorAction SilentlyContinue
                Write-Host "$svcName set to $startupType and started." -ForegroundColor Green
            } else {
                Write-Host "$svcName non-existent." -ForegroundColor Yellow
            }
        }
    }
}

# Process all service lists
Write-Host "Configuring services..." -ForegroundColor Cyan
Set-ServiceStartup -serviceLists @($updates, $telemetry, $filesystem, $time, $networking, $services)
Write-Host "Service configuration complete." -ForegroundColor Cyan
