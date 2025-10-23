### This is the core of the project, that you launch to start the tweaking project when you have fulfilled the prerequisites
### of getting Git installed, cloning the repo and this script being launched as an admin

# 📦 Shell Setup - Variables and Functions
Add-Type -AssemblyName PresentationCore
$mediaPlayer = New-Object System.Windows.Media.MediaPlayer
$VerbosePreference = "SilentlyContinue"
$arch = $env:PROCESSOR_ARCHITECTURE
$sprtor = { Write-Host "_____________________________________________________________________________________________________________________________________________________________________________________________" }
$toptui = {
        Clear-Host
        & $sprtor
        Write-Host " _______  __   __  __    _  _______  ___      ___   __   __  __   __         ------------------";
        Write-Host "|       ||  | |  ||  |  | ||       ||   |    |   | |  | |  ||  |_|  |        -        -       -";
        Write-Host "|    ___||  |_|  ||   |_| ||    ___||   |    |   | |  | |  ||       |        -        -       -";
        Write-Host "|   |___ |       ||       ||   |___ |   |    |   | |  |_|  ||       |        ------------------";
        Write-Host "|    ___||_     _||  _    ||    ___||   |___ |   | |       ||       |        -        -       -";
        Write-Host "|   |      |   |  | | |   ||   |___ |       ||   | |       || ||_|| |        -        -       -";
        Write-Host "|___|      |___|  |_|  |__||_______||_______||___| |_______||_|   |_|        ------------------";
        Write-Host "For Windows NT";
        Write-Host
        Write-Host " Home: https://github.com/MrGrappleMan/Fynelium-NT/ ";
        & $sprtor
}
$svcset = {
	param($svcName, $choice)
	switch ($choice) {
		"0" {
			Write-Host "→ Disabling and stopping service: $svcName"
			Stop-Service -Name $svcName -ErrorAction Continue
			Set-Service -Name $svcName -StartupType Disabled
		}
		"1" {
			Write-Host "→ Enabling and starting service: $svcName"
			Start-Service -Name $svcName -ErrorAction Continue
			Set-Service -Name $svcName -StartupType Automatic
		}
		default {
			Write-Host "→ Skipping: $svcName"
		}
	}
}
$userask = {
	Write-Host ""
	Write-Host "Options:"
	Write-Host "[X] Skip  |  [0] No  |  [1] Yes"
	Write-Host "(Auto-skip in 5 seconds...)" -ForegroundColor Yellow

	$timeout = 5
	$stopwatch = [Diagnostics.Stopwatch]::StartNew()
	$choice = "X"  # default if timeout

	while ($stopwatch.Elapsed.TotalSeconds -lt $timeout) {
		if ([Console]::KeyAvailable) {
			$key = [Console]::ReadKey($true).Key
			switch ($key) {
				"Y" { $choice = "1"; break }
				"N" { $choice = "0"; break }
				"X" { $choice = "X"; break }
				"NumPad1" { $choice = "1"; break }
				"NumPad0" { $choice = "0"; break }
			}
		}
		Start-Sleep -Milliseconds 100
	}

	$stopwatch.Stop()
	Write-Host "→ Selected: $choice"
	return $choice
}
$isAdmin = ([System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
Set-Location "$Env:windir\\Temp\\Fynelium-NT\\"

# Has administrator permissions?
# 1 - Go ahead, execute the rest of the script
# 0 - Make the script elevate itself
if (-not $isAdmin) {
    Write-Host "This script needs adminstrator rights to function properly" -ForegroundColor Red
    Write-Host "Attempting to self-elevate, by re running through a new instance..."
    Start-Sleep -s 1
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$Env:windir\\Temp\\Fynelium-NT\\script\\main.ps1`"" -Verb RunAs
    exit
}

# ⏩ Filesystem - Copy over configurations
robocopy $Env:windir\\Temp\\Fynelium-NT\\FSRoot "C:\" /E

## 👋 User Prompts

# Xbox
& $toptui
Write-Host "Do you use anything related to Xbox?"
Write-Host ""
Write-Host "Unnecesary services will be disabled if you do not use them"
$choice = & $userask
& $svcset "XblAuthManager" $choice
& $svcset "GameSave" $choice

# Bluetooth
& $toptui
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
& $toptui
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
& $toptui
Write-Host "Do you use Docker, VirtualBox, Hyper-V, WSL, VMware, Android emulator, or any other virtualization, containerization or emulation software?"

$choice = & $userask
if ($choice -eq "1") {
    bcdedit /set hypervisorlaunchtype off
} elseif ($choice -eq "2") {
    bcdedit /set hypervisorlaunchtype auto
}

### --- AUTOMATED --- ###
& $toptui
Write-Host "You may now leave your device idle and let the process complete uninterrupted"
Write-Host "After it has completed, it should automatically restart your device"
Start-Sleep -s 10
& $toptui

# 🔋 Power Configuration ( PowerCfg ) - Energy efficiency
powercfg /H ON # For fast startup and getting back to working faster from where you left off
powercfg /Change monitor-timeout-ac 3 # Turn screen off after 3 min while charging
powercfg /Change monitor-timeout-dc 3 # Turn screen off after 3 min on battery
powercfg /Change disk-timeout-ac 1 # Turns drive off after 1 min while charging. If the device is a NAS or a file or disk recovery station dealing w/ HDDs, set this to 0.
powercfg /Change disk-timeout-dc 1 # Turns drive off after 1 min while on battery. Assuming you use SSDs, this will save you A LOT of energy, despite SSDs aready being efficient.
powercfg /Change standby-timeout-ac 0 # Never sleep while charging
powercfg /Change standby-timeout-dc 5 # Sleep after 5 min on battery
powercfg /Change hibernate-timeout-ac 0 # Never hibernate while charging
powercfg /Change hibernate-timeout-dc 15 # Hibernate after 15 min on battery
##powercfg.exe -import "!cd!\powerplan.pow">nul

# 😈 Services
powershell "$Env:windir\Temp\Fynelium-NT\script\services.ps1"

# 📒 Memory Management Agent ( MMAgent )
Enable-MMAgent -ApplicationLaunchPrefetching
Enable-MMAgent -ApplicationPreLaunch
Enable-MMAgent -MemoryCompression # Like ZRAM
Enable-MMAgent -OperationAPI
Enable-MMAgent -PageCombining
Set-MMAgent -MaxOperationAPIFiles 8192

# 🌱 Boot Configuration Data Editor ( BCDEdit )
bcdedit /set bootlog no # Only for debugging
bcdedit /set bootmenupolicy Standard
bcdedit /set bootstatuspolicy DisplayAllFailures
bcdedit /set quietboot on 
bcdedit /set sos off
#bcdedit /set nocrashautoreboot off
bcdedit /set bootuxdisabled off # Keeps windows boot experience
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

# ⏱️ Time Win32 
w32tm /register
w32tm /config /syncfromflags:all /manualpeerlist:"time.google.com time.windows.com time.cloudflare.com pool.ntp.org time.facebook.com time.apple.com time.aws.com" /reliable:YES /update

# 🗄️ Filesystem Utility ( FSUtil)
fsutil behavior set DisableDeleteNotify 0 # Allow drive trimming for health and performance
fsutil behavior set disablelastaccess 1 # No logging when a file was last edited, less disk writes and overhead
fsutil behavior set memoryusage 2 # More caching
fsutil behavior set disable8dot3 1 # No old filename fallback, less overhead

# 🤔 Mixed-Undecided
slmgr /ato # Forces a Windows activation check
# takeown /r /a /d y /f $env:SystemDrive\Windows.old # Takes permissions before deleting old Windows, risky
Remove-Item -Path $env:SystemDrive\Windows.old -Recurse -Force # Removes old Windows data

# 🧾 Registry ( regedit )
Set-Location "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\" # Sets the directory to where all registry exports are stored
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\Network.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\PowerUsr.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\System.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\Telemetry.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\UI.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\UX.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\Update.reg"

# 🏪 Winget
winget upgrade --all # Upgrade
Set-Location "$Env:windir\\Temp\\Fynelium-NT\\export\\winget\\" # Sets the directory to where all jsons are stored
winget import -i dev.json --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements
winget import -i fs.json --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements
winget import -i game.json --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements
winget import -i media.json --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements
winget import -i network.json --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements
winget import -i productive.json --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements
winget import -i rice.json --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements
winget import -i social.json --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements
winget import -i system.json --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements

# ✅ Restart, to finalize
Restart-Computer -Force
