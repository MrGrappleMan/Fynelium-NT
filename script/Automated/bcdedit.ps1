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
