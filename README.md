![Last Commit made to repository](https://img.shields.io/github/last-commit/MrGrappleMan/Fynelium-NT?style=for-the-badge)

# Fynelium for Windows

## What it has to offer

### 1. 🚀 Better efficiency and performance

1. Enable RAM Compression
2. Foreground application priority over background services
3. Network optimizations for greater throughput and reduced latency
4. EnergyStarX with the EcoQoS API for throttling background applications

### 2. ☯️ Productive environment

1. File Explorer tweaks for advanced and convenient file handling
2. The all new Spacedrive
3. Subtler animations
4. [Komorebi rice 🍉](https://lgug2z.github.io/komorebi/)
5. Updates interfere less with your experience
6. Reduction of unnecessary information, suggestions and advertisements
7. Smooth scrolling and minor anti-aliasing
8. Modded Bibata cursors
*. Optional tweaks for potato PCs

### 3. ♻️ Automated system maintenance and management

1. Updates and drivers handled automatically
2. Drivers are handled as per modern algorithms
3. Windows' engine handles UEFI setup utility settings for itself for optimal performance
4. Drive trimming for longer drive lifespan and better speed
5. Advanced Telemetry to help accelerate Windows development

## Installation
### Suggestions
An activated copy of Windows 11, still works on 10.
8GB RAM
Use the "Release Preview" insider channel or the other builds as you prefer

### Requirements
Administrator permissions
Internet access, preferrably uninterupted

Search for "Terminal", press Ctrl+Shift+Enter to launch in elevated mode. Use the Terminal UWP app, which has tabs.
You will get a UAC prompt, click yes
Paste the text below into the newly launched window, assuming your shell is powershell. Copy it with the button in the top right corner.

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
Now you should have started the execution of the script.
The first phase asks for manual interaction, and then it begins to perform common optimizations unattended.
Even though interaction will not be required later, you should still monitor it. See any error? Some are expected to occur

### [More Documentation](https://www.notion.so/Windows-27642d161cf980b395c2fbbd1d1f70ae?source=copy_link)

## Legal

This repository and its contents are provided as-is without any warranty of any kind.
I am not liable for any direct, indirect, or consequential damage to your system, data, or hardware arising from the use of this guide or its scripts.

Proceed entirely at your own risk. Always back up your data and review the scripts before executing them.

While the likelihood of critical issues is low, results may vary depending on your environment and configuration.

By using or referencing any part of this repository, you acknowledge that you understand and accept these conditions.

The above mentioned tweaks are not guaranteed to work 100% of the time due to hardware diversity, your ISP running its servers on potatoes Microsoft or other factors.
It tries its best to optimize Windows
