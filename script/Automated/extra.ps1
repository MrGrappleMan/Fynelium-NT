# Other small scripts

# ⏱️ Win32 Time
w32tm /register
w32tm /config /syncfromflags:all /manualpeerlist:"time.google.com time.windows.com time.cloudflare.com pool.ntp.org time.facebook.com time.apple.com time.aws.com" /reliable:YES /update

# 🏪 Winget
winget upgrade --all # Upgrade
Set-Location "$Env:windir\\Temp\\Fynelium-NT\\export\\winget\\" # Sets the directory to where all jsons are stored
Get-ChildItem -File | ForEach-Object { winget import -i $_.FullName --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements }

# 🧾 Registry ( regedit )
Set-Location "$Env:windir\\Temp\\Fynelium-NT\\export\\registry\\" # Sets the directory to where all registry exports are stored
Get-ChildItem -File | ForEach-Object { regedit /s $_.FullName }=

slmgr /ato # Forces a Windows activation check
# takeown /r /a /d y /f $env:SystemDrive\Windows.old # Takes permissions before deleting old Windows, risky
Remove-Item -Path $env:SystemDrive\Windows.old -Recurse -Force # Removes old Windows data
