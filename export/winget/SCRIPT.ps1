winget upgrade --all # Update
Set-Location "$Env:windir\\Temp\\Fynelium-NT\\export\\winget\\"
winget import -i .json --ignore-unavailable --ignore-versions --accept-package-agreements --accept-source-agreements
