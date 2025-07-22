# Ensure script runs as admin
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Re-run with admin rights" -ForegroundColor Red
    Read-Host "Press Enter to exit..."
    Exit
}

# Separator
$separator = "_" * 150

# Function to toggle service
Function Toggle-ServiceState($serviceName, $action) {
    If ($action -eq "disable") {
        Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
        Set-Service -Name $serviceName -StartupType Disabled
    }
    ElseIf ($action -eq "enable") {
        Start-Service -Name $serviceName -ErrorAction SilentlyContinue
        Set-Service -Name $serviceName -StartupType Automatic
    }
}

# Enable Hibernate
powercfg -h on

# Start and enable essential services
$servicesToEnable = @("Dnscache", "svsvc", "Winmgmt", "WlanSvc", "dot3svc", "SysMain", "whesvc", "WebClient", "W32Time")
Foreach ($svc in $servicesToEnable) {
    Try {
        Start-Service $svc -ErrorAction SilentlyContinue
        Set-Service $svc -StartupType Automatic
    } Catch {}
}

# Stop and disable WSearch
Toggle-ServiceState -serviceName "WSearch" -action "disable"

# Import power plan
powercfg.exe -import "$PSScriptRoot\JustPerformance.pow" | Out-Null

# Sync Time
w32tm /config /syncfromflags:manual /manualpeerlist:"time.google.com time.windows.com time.cloudflare.com time.facebook.com time.apple.com" /reliable:yes /update
Restart-Service w32time
w32tm /resync /force

# Import Registry Tweaks
regedit /s "$PSScriptRoot\jp.reg"

# Main Menu Loop
Do {
    Clear-Host
    Write-Host @"
    $separator
    Hello $env:USERNAME! I am not responsible for any damage.
    BEFORE YOU PROCEED, review this script on GitHub.
    Reboot after exiting for changes to apply.
    $separator

    Options:
    X. Exit
    1. Recommended Browser Flags
    2. Printing (Spooler, Fax)
    3. Windows Image Acquisition (StiSvc)
    4. Bluetooth (BTAGService, bthserv)
    5. Remote Desktop (SessionEnv, TermService, UmRdpService, RemoteRegistry)
    6. System Accuracy (HPET & Dynamic Ticks)
    7. Hypervisor (bcdedit)
"@
    $choice = Read-Host "Choose an option (1-7, X)"

    Switch ($choice) {
        "1" {
            Get-Content "$PSScriptRoot\chromium.txt"
            Get-Content "$PSScriptRoot\firefox.txt"
            Pause
        }
        "2" {
            Write-Host "Disable if you do not use a printer."
            Toggle-ServiceState -serviceName "Spooler" -action (Read-Host "Disable or Enable? (disable/enable)")
            Toggle-ServiceState -serviceName "Fax" -action (Read-Host "Disable or Enable? (disable/enable)")
        }
        "3" {
            Write-Host "Affects scanners, cameras, Android PTP."
            Toggle-ServiceState -serviceName "StiSvc" -action (Read-Host "Disable or Enable? (disable/enable)")
        }
        "4" {
            Write-Host "Disables Bluetooth services for security/performance."
            Toggle-ServiceState -serviceName "BTAGService" -action (Read-Host "Disable or Enable? (disable/enable)")
            Toggle-ServiceState -serviceName "bthserv" -action (Read-Host "Disable or Enable? (disable/enable)")
        }
        "5" {
            Write-Host "Disables Remote Desktop related services."
            $rdpServices = @("SessionEnv", "TermService", "UmRdpService", "RemoteRegistry")
            Foreach ($svc in $rdpServices) {
                Toggle-ServiceState -serviceName $svc -action (Read-Host "Disable or Enable? (disable/enable)")
            }
        }
        "6" {
            Write-Host "Dynamic tick disables power savings but may improve latency."
            $dynTickAction = Read-Host "Disable or Enable? (disable/enable)"
            If ($dynTickAction -eq "disable") {
                bcdedit /set disabledynamictick yes
                bcdedit /deletevalue useplatformclock
            } ElseIf ($dynTickAction -eq "enable") {
                bcdedit /set disabledynamictick no
                bcdedit /set useplatformclock true
            }
        }
        "7" {
            Write-Host "Used for VMs, emulators, WSL2."
            $hvAction = Read-Host "Disable or Enable Hypervisor? (disable/enable)"
            If ($hvAction -eq "disable") {
                bcdedit /set hypervisorlaunchtype off
            } ElseIf ($hvAction -eq "enable") {
                bcdedit /set hypervisorlaunchtype auto
            }
        }
        "X" {
            Break
        }
        Default {
            Write-Host "Invalid Option" -ForegroundColor Yellow
        }
    }
    Pause
} While ($true)

# Cleanup
Write-Host "Cleaning up temporary files and caches..."
Stop-Service -Name "wuauserv" -Force
Remove-Item -Recurse -Force "$env:windir\SoftwareDistribution\Download\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:TEMP\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\Temp\*" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "$env:windir\Prefetch\*" -ErrorAction SilentlyContinue
ipconfig /flushdns
ipconfig /registerdns
ipconfig /release
ipconfig /renew
wuauclt.exe /updatenow
Start-Service -Name "wuauserv"
Write-Host "Done. You may reboot now."
