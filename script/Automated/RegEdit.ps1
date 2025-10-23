# 🧾 Registry Editor ( regedit )
Set-Location "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\" # Sets the directory to where all registry exports are stored
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\Network.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\PowerUsr.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\System.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\Telemetry.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\UI.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\UX.reg"
regedit /s "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\Update.reg"
