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
set toggleshow="%seperator% ^& echo Options: ^& echo X.Return ^& echo 1.Disable ^& echo 2.Enable ^& choice /C 12X /N"
color 07
powercfg -h on
sc start "tzautoupdate">nul & sc config tzautoupdate"" start=auto>nul
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

bcdedit /set disabledynamictick yes
bcdedit /set useplatformtick yes
bcdedit /set usefirmwarepcisettings no
bcdedit /set tscsyncpolicy enhanced
bcdedit /set uselegacyapicmode no
bcdedit /set usephysicaldestination no
bcdedit /set tpmbootentropy ForceDisable
bcdedit /set bootux Disabled
bcdedit /set loadoptions DDISABLE_INTEGRITY_CHECKS
bcdedit /set nointegritychecks Yes
bcdedit /set testsigning No
bcdedit /set hypervisorlaunchtype off
bcdedit /set nx AlwaysOff

powercfg.exe -import "!cd!\JustPerformance.pow">nul
w32tm /config /syncfromflags:manual /manualpeerlist:"time.google.com time.windows.com time.cloudflare.com time.facebook.com time.apple.com" /reliable:YES /update & net stop w32time & net start w32time & w32tm /resync /force
regedit /s jp.reg
:home
cls
echo 	_________             _____                                                                             
echo 	______  /___  __________  /_                                                                            
echo 	___ _  /_  / / /_  ___/  __/_______            ________                                                 
echo 	/ /_/ / / /_/ /_(__  )/ /_ ___  __ \______________  __/___________________ _________ __________________ 
echo 	\____/  \____/ /____/ \__/ __  /_/ /  _ \_  ___/_  /_ _  __ \_  ___/_  __ `__ \  __ `/_  __ \  ___/  _ \
echo 	                           _  ____//  __/  /   _  __/ / /_/ /  /   _  / / / / / /_/ /_  / / / /__ /  __/
echo 	                           /_/     \___//_/    /_/    \____//_/    /_/ /_/ /_/\__,_/ /_/ /_/\___/ \___/
%seperator%
echo Hello %username%! I am not responsible for any data loss, malfunctioning or any kind of damage done to your device.
echo YOU have chosen to do this modification.
echo BEFORE YOU PROCEED, see the script on GitHub so that you can debug your system easily.
echo Exit only by using the provided option for removal of cache and and other optimizations.
echo Consider rebooting after exiting for all changes to take effect.
%seperator%
echo Options:
echo X.Exit
echo 1.Recommended Browser Flags
echo 2.Printing (Spooler, Fax)
echo 3.Windows Image Acquisition (StiSvc)
echo 4.Blutooth (BTAGService, bthserv)
echo 5.Remote Desktop (SessionEnv, TermService, UmRdpService, RemoteRegistry)
echo 6.System accuracy(HPET and Dynamic Ticks)
echo 7.Hypervisor
choice /C 123456789X /N
cls
if !el!==1 (
type chromium.txt
type firefox.txt
echo Press any key to return...
pause>nul
goto home
)
if !el!==2 (
	echo Name: Printing(Spooler, Fax)
        echo Disable if you do not use a printer. This considers virtual printers as well.
	echo Manages print jobs sent from the computer to the printer or print server.
	echo It can store multiple print jobs in the print queue or buffer retrieved by the printer or print server.
	!toggleshow!
	set svcnme=Spooler
	!svcopt!
	set svcnme=Fax
	!svcopt!
	goto home
)
if !el!==3 (
	echo Name: Windows Image Acquisition(StiSvc)
	echo Waits until you press the button on your scanner and then manages the process of getting the image where it needs to go.
	echo This also affects communication with cameras and Android PTP that you connect directly to your computer, so be aware of that if you need this function.
	!toggleshow!
	set svcnme=StiSvc
	!svcopt!
	goto home
)
if !el!==4 (
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
	goto home
)
if !el!==5 (
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
	goto home
)
if !el!==6 (
	echo Name: System accuracy(HPET and Dynamic Ticks)
	echo Type: Program
	echo This command forces the kernel timer to constantly poll for interrupts instead of wait for them.
	echo Dynamic tick was implemented as a power saving feature for laptops but hurts desktop performance.
	echo You should not change this
	!toggleshow!
	if !el!==1 (bcdedit /set disabledynamictick no & bcdedit /set useplatformclock true)
	if !el!==2 (bcdedit /set disabledynamictick yes & bcdedit /deletevalue useplatformclock)
	goto home
)
if !el!==7 (
	echo Name: Hypervisor(using bcdedit)
	echo Type: Program
	echo Used for VMs, Emulators and Subsystems.
	echo Disable if not in use.
	!toggleshow!
	if !el!==1 (bcdedit /set hypervisorlaunchtype off)
	if !el!==2 (bcdedit /set hypervisorlaunchtype on)
	goto home
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
wuauclt.exe /updatenow
net start wuauserv>nul

exit
endlocal
