# Check if elevated to administrator
$isAdmin = ([System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Re-run with admin rights" -ForegroundColor Red
    Write-Host "Press Enter to exit"
    Read-Host
    exit
}

# ShellSetup
$VerbosePreference = "SilentlyContinue"
$arch = $env:PROCESSOR_ARCHITECTURE
$sprtor = "_____________________________________________________________________________________________________________________________________________________________________________________________"
$svcset = {
    param($svcName, $choice)
    if ($choice -eq "1") {
        Stop-Service -Name $svcName -ErrorAction SilentlyContinue
        Set-Service -Name $svcName -StartupType Disabled
    } elseif ($choice -eq "2") {
        Start-Service -Name $svcName -ErrorAction SilentlyContinue
        Set-Service -Name $svcName -StartupType Automatic
    }
}
$userask = {
    Write-Host "Options:"
    Write-Host "X. Skip"
    Write-Host "1. No"
    Write-Host "2. Yes"
    $choice = Read-Host "Enter choice (1, 2, X)"
    return $choice
}
cd "$Env:windir\\Temp\\Fynelium-NT\\"

# FS-Copy
robocopy $Env:windir\\Temp\\Fynelium-NT\\FSRoot "C:\" /E

# UserPrompts

# Xbox
Write-Host $sprtor
Write-Host "Do you use anything related to Xbox?"
Write-Host ""
Write-Host "Unnecesary services will be disabled if you do not use them"
$choice = & $userask
& $svcset "XblAuthManager" $choice
& $svcset "GameSave" $choice

# Bluetooth
Write-Host $sprtor
Write-Host "Do you use Bluetooth for anything in any form, even cases for Nearby Share or Phone Link?"
Write-Host ""
Write-Host "Stopping this service causes paired Bluetooth devices to fail to operate"
Write-Host "It prevent new devices from being discovered or paired"
Write-Host "Yet it can also serve as a safety measure from attacks like KNOB or BLUFFS"
$choice = & $userask
& $svcset "BluetoothUserService" $choice
& $svcset "BTAGService" $choice
& $svcset "bthserv" $choice

# RemoteAccess
Write-Host $sprtor
Write-Host "Do you use remote desktop or remotely manage your device?"
Write-Host ""
Write-Host "It makes remote control of your computer possible."
Write-Host "However, Microsoft Support could use this to fix issues."
Write-Host "Windows's Remote support won't work if you disable these services."
Write-Host "Disabling these helps improve the security of your device in general"
Write-Host "You may use Parsec or Moonlight without issues"
$choice = & $userask
& $svcset "SessionEnv" $choice
& $svcset "TermService" $choice
& $svcset "UmRdpService" $choice
& $svcset "RemoteRegistry" $choice

# Virtualization
Write-Host $sprtor
Write-Host "Do you use Docker, VirtualBox, Hyper-V, WSL, VMware, Android emulator, or any other virtualization, containerization or emulation software?"

$choice = & $userask
if ($choice -eq "1") {
    bcdedit /set hypervisorlaunchtype off
} elseif ($choice -eq "2") {
    bcdedit /set hypervisorlaunchtype auto
}

# PowerCFG
powercfg -h on # For fast startup and getting back to working faster
##powercfg.exe -import "!cd!\powerplan.pow">nul

# Services
powershell "$Env:windir\Temp\Fynelium-NT\script\services.ps1"

# MMAgent
Enable-MMAgent -ApplicationLaunchPrefetching
Enable-MMAgent -ApplicationPreLaunch
Enable-MMAgent -MemoryCompression
Enable-MMAgent -OperationAPI
Enable-MMAgent -PageCombining
Set-MMAgent -MaxOperationAPIFiles 8192

# BCDEdit
bcdedit /set bootlog yes
bcdedit /set bootmenupolicy Standard
bcdedit /set bootstatuspolicy DisplayAllFailures
bcdedit /set quietboot on
bcdedit /set sos off
#bcdedit /set nocrashautoreboot off
bcdedit /set bootuxdisabled off
#bcdedit /set maxproc yes
bcdedit /set disabledynamictick no
#bcdedit /set usefirmwarepcisettings no
bcdedit /set nointegritychecks off
#bcdedit /set groupaware on
#bcdedit /set maxgroup on
#bcdedit /set onecpu off
#bcdedit /set vsmlaunchtype Auto
bcdedit /set nx Optin
#bcdedit /deletevalue useplatformclock
#bcdedit /set forcelegacyplatform no
#bcdedit /set nolowmem off
#bcdedit /set x2apicpolicy enable
#bcdedit /set useplatformtick yes
#bcdedit /set tscsyncpolicy enhanced
#bcdedit /set uselegacyapicmode no
#bcdedit /set usephysicaldestination no
#bcdedit /set tpmbootentropy default
#bcdedit /set testsigning No

# Time
w32tm /register
w32tm /config /syncfromflags:all /manualpeerlist:"time.google.com time.windows.com time.cloudflare.com pool.ntp.org time.facebook.com time.apple.com time.aws.com" /reliable:YES /update

# Filesystem
fsutil behavior set DisableDeleteNotify 0 # Allow drive to be trimmed for longetivity
fsutil behavior set disablelastaccess 1 # Prevents Windows from logging when a file was last modified, reduce disk writes and overhead
fsutil behavior set memoryusage 2 # Allow more caching
fsutil behavior set disable8dot3 1 # Disables old filename fallback creation, reducing overhead

# Registry
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry.reg"

# Winget
cd "$Env:windir\Temp\Fynelium-NT\export\"
winget import -i winget.json --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements
