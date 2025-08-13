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
set svcset="if !el!==1 (sc stop "!svcnme!" ^& sc config "!svcnme!" start=disabled) ^& if !el!==2 (sc start "!svcnme!" ^& sc config "!svcnme!" start=auto)"
set userask="echo Options: ^& echo X. Skip ^& echo 1. Disable ^& echo 2. Enable ^& choice /C 12X /N"
color 07

cls
echo Hello %username%! I am not responsible for any data loss, malfunctioning or any kind of damage done to your device.
echo YOU have chosen to do this modification. Save all your work before proceeding. Leaving your device idle when the process starts is recommended.
%seperator%
echo PRESS ANY KEY TO START
pause>nul
cls

	echo Name: Printing or Fax
    echo TLDR: Disable if you do not use a printer, fax or a virtual print service.
	echo.
	echo Manages print jobs sent from the computer to the printer or print server
	echo It can store multiple print jobs in the print queue or buffer retrieved by the printer or print server
	!userask!
    set svcnme=PrintNotify
  	!svcset!
	set svcnme=Spooler
	!svcset!
	set svcnme=Fax
	!svcset!
	set svcnme=PrintWorkflowUserSvc
	!svcset!
	cls

	echo Name: Camera and Image Scanners
	echo TLDR: Disable if you do not use image scanners or connect cameras
	echo.
	echo Waits until you press the button on your scanner and then manages the process of getting the image where it needs to go
	echo This also affects communication with cameras and Android PTP that you connect directly to your computer, so be aware of that if you need this function
	!userask!
	set svcnme=StiSvc
	!svcset!
	set svcnme=FrameServer
	!svcset!
	set svcnme=WiaRpc
    !svcset!
	cls

	echo Name: Xbox
	echo TLDR: Disable if you do not use anything related to Xbox
	echo.
	!userask!
	set svcnme=XblAuthManager
	!svcset!
	set svcnme=GameSave
	!svcset!
	cls

	echo Name: Blutooth
    echo TLDR: Disable if you do not use Bluetooth
	echo.
	echo Stopping this service causes paired Bluetooth devices to fail to operate
	echo It prevent new devices from being discovered or paired
	echo Yet it can also serve as a safety measure from attacks like KNOB or BLUFFS
	!userask!
	set svcnme=BluetoothUserService
	!userask!
	set svcnme=BTAGService
	!svcset!
	set svcnme=bthserv
	!svcset!
	cls

	echo Name: Remote Access
	echo TLDR: Disable if you don't use remote desktop or remotely manage your device
	echo.
	echo These services make remote control of your computer possible.
	echo However, Microsoft Support could use this to fix issues.
	echo Windows's Remote support won't work if you disable these services.
	echo So, disabling these helps improve the security of your device, as they can be used in fake support scams.
	echo You may use Chrome Remote Desktop or most other 3rd party apps without any issues.
	!userask!
	set svcnme=SessionEnv
	!svcset!
	set svcnme=TermService
	!svcset!
	set svcnme=UmRdpService
	!svcset!
    set svcnme=RemoteRegistry
	!svcset!
	cls

	echo Name: Virtualization or Containerization
	echo TLDR: Enable if you use Docker, VirtualBox, Hyper-V, WSL, VMware, Bluestacks, or any other virtualization or emulation software
	echo.
	!userask!
	if !el!==1 (bcdedit /set hypervisorlaunchtype off)
	if !el!==2 (bcdedit /set hypervisorlaunchtype on)
    cls

::Trigger Tweaks OR Repairs
sfc /scannow
chkdsk /f /r
wsreset.exe
dism /Online /CheckHealth 
dism /Online /ScanHealth
dism /Online /Cleanup-Image /RestoreHealth
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
pnputil /remove-device /class "Mouse" /subtree
pnputil /remove-device /class "Keyboard" /subtree
pnputil /remove-device /class "HIDClass" /subtree
pnputil /remove-device /class "USBDevice" /subtree
pnputil /remove-device /class "USB" /subtree
timeout 15
pnputil.exe /scan-devices

:: Toggle Tweaks:
powercfg -h off

sc start "SensrSvc">nul & sc config "SensrSvc" start=auto>nul
sc start "SensorService">nul & sc config "SensorService" start=auto>nul
sc start "NetTcpPortSharing">nul & sc config "NetTcpPortSharing" start=auto>nul
sc start "wisvc">nul & sc config "wisvc" start=auto>nul
sc start "WpnUserService">nul & sc config "WpnUserService" start=auto>nul
sc start "WpnService">nul & sc config "WpnService" start=auto>nul
sc start "UserDataSvc">nul & sc config "UserDataSvc" start=auto>nul
sc start "UnistoreSvc">nul & sc config "UnistoreSvc" start=auto>nul
sc start "UevAgentService">nul & sc config "UevAgentService" start=auto>nul
sc start "UsoSvc">nul & sc config "UsoSvc" start=auto>nul
sc start "InstallServicec">nul & sc config "InstallService" start=auto>nul
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
sc start "WSearch">nul & sc config "WSearch" start=auto>nul

bcdedit /set bootlog yes
bcdedit /set bootmenupolicy Standard
bcdedit /set bootstatuspolicy DisplayAllFailures
bcdedit /set quietboot on
bcdedit /set sos on
bcdedit /set nocrashautoreboot off
bcdedit /set bootuxdisabled off
bcdedit /set maxproc yes
bcdedit /set onecpu no
bcdedit /set disabledynamictick no
bcdedit /set usefirmwarepcisettings no
bcdedit /set nointegritychecks off
bcdedit /set groupaware on
bcdedit /set maxgroup on
bcdedit /set onecpu off
bcdedit /set vsmlaunchtype Auto
bcdedit /set nx Optin
bcdedit /deletevalue useplatformclock

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

w32tm /config /syncfromflags:manual /manualpeerlist:"time.google.com time.windows.com time.cloudflare.com pool.ntp.org time.facebook.com time.apple.com time.aws.com" /reliable:YES /update & net stop w32time & net start w32time & w32tm /resync /force

regedit /s registry.reg

::Special Tweak
::powercfg.exe -import "!cd!\powerplan.pow">nul

exit
endlocal








