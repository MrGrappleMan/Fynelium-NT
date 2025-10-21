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
    "A",
    "UsoSvc",
    "wuauserv",
    "WaaSMedicSvc",
    "InstallService",
    "DoSvc"
)

# Reporting, data collection, analytics of various types
$telemetry = @(
    "A",
    "DiagTrack",
    "wisvc"
)

# For handling data, drive management, backups, file management, indexing
$filesystem = @(
    "A",
    "WSearch",
    "SysMain",
    "UnistoreSvc",
    "UserDataSvc"
)

# NTP, timezones, system clocks
$time = @(
    "A",
    "tzautoupdate",
    "W32Time"
)

# Proper establishment of local, internal and internet connections
$networking = @(
    "A",
    "NetTcpPortSharing",
    "Dnscache",
    "WlanSvc",
    "dot3svc",
    "WebClient"
)

# Uncategorized
$uncategorized = @(
    "A",
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
        $startupType = $list[0]
        if ($startupType -notin @("A", "B")) { continue } # Skip invalid startup types
        foreach ($svcName in $list[1..($list.Count-1)]) {
            $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
            if ($svc) {
                if ($startupType -eq "A") {
                    Set-Service -Name $svcName -StartupType Automatic -ErrorAction SilentlyContinue
                    Write-Host "$svcName set to Automatic" -ForegroundColor Green
                } elseif ($startupType -eq "B") {
                    & sc.exe config $svcName start= delayed-auto | Out-Null
                    if ($LASTEXITCODE -eq 0) {
                        Write-Host "$svcName set to Automatic (Delayed Start)" -ForegroundColor Green
                    } else {
                        Write-Host "Failed to set $svcName to Automatic (Delayed Start)" -ForegroundColor Red
                    }
                }
                Start-Service -Name $svcName -ErrorAction SilentlyContinue
                Write-Host "$svcName started." -ForegroundColor Green
            } else {
                Write-Host "$svcName non-existent." -ForegroundColor Yellow
            }
        }
    }
}

# Process all service lists
Write-Host "Configuring services..." -ForegroundColor Cyan
Set-ServiceStartup -serviceLists @($updates, $telemetry, $filesystem, $time, $networking, $uncategorized)
Write-Host "Service configuration complete." -ForegroundColor Cyan
