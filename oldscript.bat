@echo off
setlocal enabledelayedexpansion

color 07
cls

	echo Do you use a printer, fax or a virtual print service?
	echo.
	echo Service(s) Name: PrintNotify Spooler
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

	echo Do you use image scanners, Android PTP or connect cameras?
	echo.
	echo Service(s) Name: StiSvc FrameServer WiaRpc
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

	echo Do you use anything related to Xbox?
	echo.
	echo Service(s) Name: XblAuthManager GameSave
	!userask!
	set svcnme=XblAuthManager
	!svcset!
	set svcnme=GameSave
	!svcset!
	cls

	echo Do you use Bluetooth for anything? This even considers for Nearby Share
	echo.
	echo Service(s) Name: BluetoothUserService BTAGService bthserv
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

	echo Do you use remote desktop or remotely manage your device?
	echo.
	Service(s) Name: SessionEnv TermService UmRdpService RemoteRegistry
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

	echo Name: Do you use Docker, VirtualBox, Hyper-V, WSL, VMware, Android emulator, or any other virtualization, containerization or emulation software?
	echo.
	!userask!
	if !el!==1 (bcdedit /set hypervisorlaunchtype off)
	if !el!==2 (bcdedit /set hypervisorlaunchtype on)
    cls

echo The main process has started. Keep this window open and check back after every 10-15 minutes.
echo For the time-being, avoid modifying your system files or installing or using software that does that.
echo Do not do important work or programs that keep progress via save-files on your disk.
echo Device will restart automatically within a 2 minutes and show a warning once done.

exit
endlocal





