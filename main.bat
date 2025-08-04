@echo off
setlocal enabledelayedexpansion
title Fynelium
net session
set el=!errorlevel!
if !el!==2 (
color 04
cls
echo Re-run with admin rights
echo Press any key to exit...
pause>nul
exit
)
set seperator=echo _____________________________________________________________________________________________________________________________________________________________________________________________
set svcopt="if !el!==1 (sc stop "!svcnme!" ^& sc config "!svcnme!" start=disabled) ^& if !el!==2 (sc start "!svcnme!" ^& sc config "!svcnme!" start=auto)"
set toggleshow="%seperator% ^& echo Options: ^& echo X. Return to main menu ^& echo 1. Disable ^& echo 2. Enable ^& choice /C 12X /N"
color 07
powercfg -h on
sc start "UsoSvc">nul & sc config "UsoSvc" start=auto>nul
sc start "DiagTrack">nul & sc config "DiagTrack" start=auto>nul
sc start "tzautoupdate">nul & sc config "tzautoupdate" start=auto>nul
sc start "BITS">nul & sc config "BITS" start=auto>nul
sc start "DoSvc">nul & sc config "DoSvc" start=auto>nul
sc start "wuauserv">nul & sc config "wuauserv" start=auto>nul
sc start "WaaSMedicSvc">nul & sc config "WaaSMedicSvc" start=auto>nul
sc start "Dnscache">nul & sc config "Dnscache" start=auto>nul
sc start "svsvc">nul & sc config "svsvc" start=auto>nul
sc start "Winmgmt">nul & sc config "Winmgmt" start=auto>nul
sc start "whesvc">nul & sc config "whesvc" start=auto>nul
sc start "WebClient">nul & sc config "WebClient" start=auto>nul
sc start "W32Time">nul & sc config "W32Time" start=auto>nul
sc start "WlanSvc">nul & sc config "WlanSvc" start=auto>nul
sc start "dot3svc">nul & sc config "dot3svc" start=auto>nul
sc start "SysMain">nul & sc config "SysMain" start=auto>nul
sc stop "WSearch">nul & sc config "WSearch" start=disabled>nul

:: For all:
bcdedit /set bootlog yes
bcdedit /set bootmenupolicy Standard
bcdedit /set bootstatuspolicy DisplayAllFailures
bcdedit /set quietboot off
bcdedit /set sos on
bcdedit /set nocrashautoreboot off
bcdedit /set bootuxdisabled off
bcdedit /set maxproc yes
bcdedit /set onecpu no
bcdedit /set disabledynamictick no
bcdedit /set usefirmwarepcisettings yes
bcdedit /set nointegritychecks off
bcdedit /set groupaware on
bcdedit /set maxgroup on
bcdedit /set onecpu off
bcdedit /set vsmlaunchtype Auto
bcdedit /set nx Optin

:: Unstable or compatibility issues:
:: bcdedit /set forcelegacyplatform no
:: bcdedit /set nolowmem off
:: bcdedit /set x2apicpolicy enable
:: bcdedit /set useplatformtick yes
:: bcdedit /set tscsyncpolicy enhanced
:: bcdedit /set uselegacyapicmode no
:: bcdedit /set usephysicaldestination no
:: bcdedit /set tpmbootentropy default
:: bcdedit /set testsigning No
:: bcdedit /set hypervisorlaunchtype on

powercfg.exe -import "!cd!\powerplan.pow">nul
w32tm /config /syncfromflags:manual /manualpeerlist:"time.google.com time.windows.com time.cloudflare.com time.facebook.com time.apple.com pool.ntp.org" /reliable:YES /update & net stop w32time & net start w32time & w32tm /resync /force
regedit /s registry.reg
:home
cls
echo  ________   ___    ___  ________       _______       ___           ___      ___  ___      _____ ______      
echo |\  _____\ |\  \  /  /||\   ___  \    |\  ___ \     |\  \         |\  \    |\  \|\  \    |\   _ \  _   \    
echo \ \  \__/  \ \  \/  / /\ \  \\ \  \   \ \   __/|    \ \  \        \ \  \   \ \  \\\  \   \ \  \\\__\ \  \   
echo  \ \   __\  \ \    / /  \ \  \\ \  \   \ \  \_|/__   \ \  \        \ \  \   \ \  \\\  \   \ \  \\|__| \  \  
echo   \ \  \_|   \/  /  /    \ \  \\ \  \   \ \  \_|\ \   \ \  \____    \ \  \   \ \  \\\  \   \ \  \    \ \  \ 
echo    \ \__\  __/  / /       \ \__\\ \__\   \ \_______\   \ \_______\   \ \__\   \ \_______\   \ \__\    \ \__\
echo     \|__| |\___/ /         \|__| \|__|    \|_______|    \|_______|    \|__|    \|_______|    \|__|     \|__|
echo           \|___|/
%seperator%
echo Hello %username%! I am not responsible for any data loss, malfunctioning or any kind of damage done to your device.
echo YOU have chosen to do this modification. Save your work before proceeding. After tweaking, please reboot manually.
%seperator%
echo Options:
echo X. Exit
echo 1. Start
choice /C 1X /N
cls

if !el!==1 (
	echo Name: Printing
        echo Disable if you do not use a printer or a virtual print service.
	echo Manages print jobs sent from the computer to the printer or print server.
	echo It can store multiple print jobs in the print queue or buffer retrieved by the printer or print server.
	!toggleshow!
	set svcnme=Spooler
	!svcopt!
	set svcnme=Fax
	!svcopt!
	cls

	echo Name: Windows Image Acquisition
	echo Waits until you press the button on your scanner and then manages the process of getting the image where it needs to go.
	echo This also affects communication with cameras and Android PTP that you connect directly to your computer, so be aware of that if you need this function.
	!toggleshow!
	set svcnme=StiSvc
	!svcopt!
	cls

	echo Name: Blutooth(BTAGService, bthserv)
        echo Disable if you do not use bluetooth
	echo BTAGService: Service supporting the audio gateway role of the Bluetooth Handsfree Profile.
	echo bthserv: The Bluetooth service supports discovery and association of remote Bluetooth devices.
	echo Stopping or disabling this service may cause paired Bluetooth devices to fail to operate properly and prevent new devices from being discovered or paired.
	echo This can also serve as a safety measure from attacks. eg. KNOB, BLUFFS.
	!toggleshow!
	set svcnme=BTAGService
	!svcopt!
	set svcnme=bthserv
	!svcopt!
	cls

	echo Name: Remote Access(SessionEnv, TermService, UmRdpService, RemoteRegistry)
	echo These services make remote control of your computer possible.
	echo If you don't use the remote desktop functionality of Windows, disable all these services.
	echo However, Microsoft Support can potentially use remote desktop technology to diagnose issues you might be experiencing.
	echo Windows's Remote support won't work if you disable these services.
	echo This may also be a serious security issue and is used in fake support scams.
	echo So, disabling these services can also help improve the security and provide some performance to your computer.
	echo You may use Chrome Remote Desktop or most other 3rd party apps without any issues.
	!toggleshow!
	set svcnme=SessionEnv
	!svcopt!
	set svcnme=TermService
	!svcopt!
	set svcnme=UmRdpService
	!svcopt!
        set svcnme=RemoteRegistry
	!svcopt!
	cls

	echo Name: System accuracy(HPET)
	echo Type: Program
	echo This command forces the kernel timer to constantly poll for interrupts instead of wait for them.
	echo You should not change this
	!toggleshow!
	if !el!==1 (bcdedit /set useplatformclock true)
	if !el!==2 (bcdedit /deletevalue useplatformclock)
        cls

        echo Please open your web browser and change your flags accordingly
        %seperator%
        For Chrome/Edge/Brave or other Chromium based browsers,
	type chromium.txt
	%seperator%
	For Firefox/Zen/Tor or other Gecko based browsers,
	type firefox.txt
	%seperator%
	echo Spam any key 5 times to exit...
	pause>nul
	pause>nul
	pause>nul
	pause>nul
	pause>nul
)

net stop wuauserv>nul
del /F /S /Q %windir%\SoftwareDistribution\Download\*>nul
del /F /S /Q %tmp%\*>nul
del /F /S /Q %windir%\Temp\*>nul
del /F /S /Q %windir%\Prefetch\*>nul
ipconfig /flushdns>nul
ipconfig /registerdns>nul
ipconfig /release>nul
ipconfig /renew>nul
wuauclt.exe /updatenow>nul
net start wuauserv>nul

exit
endlocal



