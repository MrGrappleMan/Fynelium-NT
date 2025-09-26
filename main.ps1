# IsAdmin?
$isAdmin = ([System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]#GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]#Administrator)
if (-not $isAdmin) {
    Write-Host "Re-run with admin rights" -ForegroundColor Red
    Write-Host "Press Enter to exit"
    Read-Host
    exit
}

# Var, Func
$arch = $env:PROCESSOR_ARCHITECTURE
$sprtor = "_____________________________________________________________________________________________________________________________________________________________________________________________"
$svcset = {
    param($svcName)
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

# UserPrompts

# Printers / Fax
$sprtor
Write-Host "Do you use a printer, fax or a virtual print service?"
Write-Host ""
$choice = & $userask
& $svcset "PrintNotify"
& $svcset "Spooler"
& $svcset "Fax"
& $svcset "PrintWorkflowUserSvc"

# Scanners / Cameras
$sprtor
Write-Host "Do you use image scanners, Android PTP or connect cameras?"
Write-Host ""
Write-Host "Waits until you press the button on your scanner and then manages the process of getting the image where it needs to go"
Write-Host "This also interferes communication with cameras and Android PTP that you connect directly to your computer"
$choice = & $userask
& $svcset "StiSvc"
& $svcset "FrameServer"
& $svcset "WiaRpc"

# Xbox
$sprtor
Write-Host "Do you use anything related to Xbox?"
Write-Host ""
$choice = & $userask
& $svcset "XblAuthManager"
& $svcset "GameSave"

# Bluetooth
$sprtor
Write-Host "Do you use Bluetooth for anything in any form, even cases for Nearby Share or Phone Link?"
Write-Host ""
Write-Host "Stopping this service causes paired Bluetooth devices to fail to operate"
Write-Host "It prevent new devices from being discovered or paired"
Write-Host "Yet it can also serve as a safety measure from attacks like KNOB or BLUFFS"
$choice = & $userask
& $svcset "BluetoothUserService"
& $svcset "BTAGService"
& $svcset "bthserv"

# RemoteAccess
$sprtor
Write-Host "Do you use remote desktop or remotely manage your device?"
Write-Host ""
Write-Host "It makes remote control of your computer possible."
Write-Host "However, Microsoft Support could use this to fix issues."
Write-Host "Windows's Remote support won't work if you disable these services."
Write-Host "Disabling these helps improve the security of your device in general"
Write-Host "You may use Parsec or Moonlight without issues"
$choice = & $userask
& $svcset "SessionEnv"
& $svcset "TermService"
& $svcset "UmRdpService"
& $svcset "RemoteRegistry"

# Virtualization
$sprtor
Write-Host "Do you use Docker, VirtualBox, Hyper-V, WSL, VMware, Android emulator, or any other virtualization, containerization or emulation software?"
$choice = & $userask
if ($choice -eq "1") {
    bcdedit /set hypervisorlaunchtype off
} elseif ($choice -eq "2") {
    bcdedit /set hypervisorlaunchtype on
}

exit
$sprtor

# PowerCFG
powercfg -h on
##powercfg.exe -import "!cd!\powerplan.pow">nul

# Services

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
bcdedit /set quietboot off
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
#bcdedit /set hypervisorlaunchtype on

# NTPOptions
w32tm /register
w32tm /config /syncfromflags:all /manualpeerlist:"time.google.com time.windows.com time.cloudflare.com pool.ntp.org time.facebook.com time.apple.com time.aws.com" /reliable:YES /update
w32tm /resync

# Registry
regedit /s %windir%\Temp\Fynelium-NT\registry\main.reg
#regedit /s %windir%\Temp\Fynelium-NT\registry\unsafe.reg

# Winget
winget import --import-file winget.json --ignore-unavailable
