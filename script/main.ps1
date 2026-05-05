# 👋 User Prompts - Sends out requests to the user, asking for prompts to perform actions accordingly

# 📦 Shell Setup - Variables and Functions
Add-Type -AssemblyName PresentationCore
$mediaPlayer = New-Object System.Windows.Media.MediaPlayer
$VerbosePreference = "SilentlyContinue"
$arch = $env:PROCESSOR_ARCHITECTURE
$sprtor = { Write-Host "_____________________________________________________________________________________________________________________________________________________________________________________________" }
$toptui = {
        Clear-Host
		Write-Host
        Write-Host " _______  __   __  __    _  _______  ___      ___   __   __  __   __          _________________";
        Write-Host "|       ||  | |  ||  |  | ||       ||   |    |   | |  | |  ||  |_|  |        |        |        |";
        Write-Host "|    ___||  |_|  ||   |_| ||    ___||   |    |   | |  | |  ||       |        |        |        |";
        Write-Host "|   |___ |       ||       ||   |___ |   |    |   | |  |_|  ||       |        |________|________|";
        Write-Host "|    ___||_     _||  _    ||    ___||   |___ |   | |       ||       |        |        |        |";
        Write-Host "|   |      |   |  | | |   ||   |___ |       ||   | |       || ||_|| |        |        |        |";
        Write-Host "|___|      |___|  |_|  |__||_______||_______||___| |_______||_|   |_|        |________|________|";
        Write-Host "For Windows";
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
	Write-Host "[Y] Yes | [N] No"

	$timeout = 5
	$stopwatch = [Diagnostics.Stopwatch]::StartNew()
	$choice = "X"  # default if timeout

	while ($stopwatch.Elapsed.TotalSeconds -lt $timeout) {
		if ([Console]::KeyAvailable) {
			$key = [Console]::ReadKey($true).Key
			switch ($key) {
				"Y" { $choice = "1"; break }
				"N" { $choice = "0"; break }
			}
		}
		Start-Sleep -Milliseconds 10
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

## 👋 User Prompts

# Xbox
& $toptui
Write-Host "Do you use anything related to Xbox?"
Write-Host ""
Write-Host "Unnecesary services will be disabled if you do not use them"
$choice = & $userask
& $svcset "XblAuthManager" $choice
& $svcset "GameSave" $choice

# Remote Access
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

### --- AUTOMATED --- ###
& $toptui
Write-Host "You may now leave your device idle and let the process complete uninterrupted"
Write-Host "After it has completed, it should automatically restart your device"
Start-Sleep -s 10
& $toptui

Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$path\script\main.ps1`"" -Verb RunAs
