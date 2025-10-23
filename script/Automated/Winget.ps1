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
