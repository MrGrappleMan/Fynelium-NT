![Last Commit made to repository](https://img.shields.io/github/last-commit/MrGrappleMan/Fynelium-NT?style=for-the-badge)

# Fynelium for Windows

### 🚀 Greater System Efficiency

🧠 RAM Compression — keeps things smooth when multitasking.
⚙️ Foreground Boost — gives priority to apps you’re actually using.
🌐 Network Turbo — better throughput, lower latency.
🌱 EnergyStarX + EcoQoS — smartly throttles background stuff to save power.
📥 Free Download Manager — faster downloads & torrent support.
🔧 System Tweaks — optimized services, BCD, MMAgents, and registry settings for extra punch.

### ☯️ A Beautifully Productive Environment

🗂️ Explorer Upgrades — smarter file handling; try Spacedrive for next-gen management.
🎞️ Refined Animations — subtle, smooth, and never in your way.
🎨 Custom Rice — pre-tuned visuals & UI polish (no spoilers 👀).
🔄 Seamless Updates — updates happen quietly,  disruption.
🚫 Decluttered Experience — no ads, no nags, no useless suggestions.
🖱️ Smooth Scrolling + Anti-Aliasing — crisp visuals and fluid navigation.

### ♻️ Automated Maintenance & Management
🔄 Auto Updates + Drivers — installs & maintains what you need, hands-free.
🧩 Extra Drivers — adds optional utilities for better hardware support.
🧬 UEFI Smart Config — system optimizes BIOS/UEFI settings by itself.
💽 Drive Trimming — boosts SSD lifespan & read/write speed.
📊 Advanced Telemetry — contributes to faster Windows evolution.

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
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine

```
You may be prompted for an input by powershell incase if it is the first time you are running a powershell script on Windows.
In that case, type letter "a" and enter.

Now open a new tab in terminal and paste this. The reason being that you need a new instance of powershell to recognize Git has been installed.

```
git clone https://github.com/MrGrappleMan/Fynelium-NT.git $Env:windir\\Temp\\Fynelium-NT\\
Set-Location "$Env:windir\\Temp\\Fynelium-NT\\"
powershell "$Env:windir\\Temp\\Fynelium-NT\\script\\main.ps1"

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
