![Last Commit made to repository](https://img.shields.io/github/last-commit/MrGrappleMan/Fynelium-NT?style=for-the-badge)

# Fynelium for Windows
11 or 10

"I am not liable for any damage caused to your device by following this guide.
Proceed at your own risk, and always back up your data before attempting any modifications that this script tries to perform.
Though it is highly unlikely that anything goes wrong. Respond to the questions asked with the truth to make tweaks as per requirements"

### 1. 🚀 Better efficiency and performance

1. Enable RAM Compression
2. Foreground application priority over background services
3. Network optimizations for greater throughput and reduced latency

### 2. ☯️ Productive environment

1. File Explorer tweaks for advanced and convenient file handling
2. Subtler animations
3. [Komorebi rice 🍉](https://lgug2z.github.io/komorebi/)
4. Updates interfere less with your experience
5. Reduction of unnecessary information, suggestions and advertisements
6. Smooth scrolling and minor anti-aliasing
7. Modded Bibata cursors
*. Optional tweaks for potato PCs

### 3. ♻️ Automated system maintenance and management

1. Updates and drivers handled automatically
2. Drivers are handled as per modern algorithms
3. Windows' engine handles UEFI setup utility settings for itself for optimal performance
4. Drive trimming for longer drive lifespan and better speed
5. Advanced Telemetry to help accelerate Windows development

## Installation

Be sure to be connect to the internet and have administrator permissions
Pin Terminal to taskbar, hold Ctrl+Shift and click the app. Use the Terminal UWP app, not powershell directly. It needs to have tabs.
You will get a prompt, click yes
Paste the text below into the newly launched window, assuming your shell is powershell. I recommend copying it with the button in the top right corner.

```
cd "$Env:windir\\Temp\\"
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
Remove-Item -Path "$env:windir\\Temp\\Fynelium-NT\\" -Recurse -Force
New-Item -Path "$env:windir\\Temp\\Fynelium-NT\\" -ItemType Directory -Force
winget install --id Git.Git -e --source winget

```
You may be prompted for an input by powershell incase if it is the first time you are running a powershell script on Windows.
In that case, type letter "a" and enter.

Now open a new tab in terminal and paste this. The reason being that you need a new instance of powershell to recognize Git has been installed.

```
git clone https://github.com/MrGrappleMan/Fynelium-NT.git $Env:windir\\Temp\\Fynelium-NT\\
cd "$Env:windir\\Temp\\Fynelium-NT\\"
powershell "$Env:windir\\Temp\\Fynelium-NT\\script\\main.ps1"

```

### [More Documentation](https://www.notion.so/Windows-27642d161cf980b395c2fbbd1d1f70ae?source=copy_link)

***The above mentioned tweaks are not guaranteed to work 100% of the time due to hardware diversity, the greediness of your ISP or Microsoft or other factors.
It tries its best to optimize Windows
