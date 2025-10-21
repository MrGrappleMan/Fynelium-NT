![Last Commit made to repository](https://img.shields.io/github/last-commit/MrGrappleMan/Fynelium-NT?style=for-the-badge)

# Fynelium for Windows

## What does have to offer?

### 1. 🚀 Better efficiency and performance

1. Enable RAM Compression
2. Foreground application priority over background services.
3. Network optimizations for greater throughput and reduced latency.
4. EnergyStarX with the EcoQoS API for throttling background applications.
5. Free Download Manager for faster downloads and torrenting.
6. Tweaks made to services, BCDedit, MMAgents and Registry.

### 2. ☯️ A beautifully productive environment

1. File Explorer tweaks for advanced and convenient file handling, try Spacedrive.
2. Subtler animations to not slow you down, yet keep the navigation experience good.
3. Customized rice, won't reveal much here. Install it to see it for yourself.
4. Updates interfere less with your experience.
5. Reduction of unnecessary information, suggestions and advertisements.
6. Smooth scrolling and anti-aliasing of text.

### 3. ♻️ Automated system maintenance and management

1. Updates and drivers handled automatically.
2. Installs additional drivers, that you may find useful.
3. Windows' engine handles UEFI setup utility settings for itself for optimal performance.
4. Drive trimming for longer drive lifespan and better speed.
5. Advanced Telemetry to help accelerate Windows development.

## Installation
### Requirements
Administrator permissions.
Internet access, preferrably uninterupted.

### Suggestions
An activated copy of Windows 11, still works on 10.
8GB RAM.
Use the "Beta" insider channel or the other builds as you prefer.
Remove Edge by some other community made script and use Edge Canary.

Search for "Terminal", press Ctrl+Shift+Enter to launch with admin rights. Use the Terminal UWP app, which has tabs.
You will get a UAC prompt, click yes.
Paste the text below into the newly launched window, assuming your shell is powershell. Copy it with the button in the top right corner.

```
Set-Location "$Env:windir\\Temp\\"
Remove-Item -Path "$env:windir\\Temp\\Fynelium-NT\\" -Recurse -Force
New-Item -Path "$env:windir\\Temp\\Fynelium-NT\\" -ItemType Directory -Force
winget install --id Git.Git -e --source winget

```
You may be prompted for an input by powershell incase if it is the first time you are running a powershell script on Windows.
In that case, type letter "a" and enter.

Now open a new tab in terminal and paste this. The reason being that you need a new instance of powershell to recognize Git has been installed.

```
git clone https://github.com/MrGrappleMan/Fynelium-NT.git $Env:windir\\Temp\\Fynelium-NT\\
Set-Location "$Env:windir\\Temp\\Fynelium-NT\\"
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Unrestricted -File `"$Env:windir\\Temp\\Fynelium-NT\\script\\main.ps1`"" -Verb RunAs

```
Now you should have started the execution of the script.
The first phase asks for manual interaction, and then it begins to perform common optimizations in an unattended manner.
Even though interaction will not be required later, you should still monitor its actions. Getting errors? Some are expected to occur.

### [More Documentation](https://www.notion.so/Windows-27642d161cf980b395c2fbbd1d1f70ae?source=copy_link)

## Legal

This repository and its contents are provided as-is without any warranty of any kind.
I am not liable for any direct, indirect, or consequential damage to your system, data, or hardware arising from the use of this guide or its scripts.

Proceed entirely at your own risk. Always back up your data and review the scripts before executing them.

While the likelihood of critical issues is low, results may vary depending on your environment and configuration.

By using or referencing any part of this repository, you acknowledge that you understand and accept these conditions.

The tweaks are not guaranteed to work 100% of the time due to hardware diversity, your ISP running its servers on toasters, Microsoft or other factors.
It tries its best to optimize Windows.

There may be parts of this script that utilizes externally sourced applications which -MAY- have unethical intents, but only ethical parts are utilized.
Some may launch a GUI, the user is best suggested to only follow the instructions are per the script
