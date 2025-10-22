![Last Commit made to repository](https://img.shields.io/github/last-commit/MrGrappleMan/Fynelium-NT?style=for-the-badge)

# Fynelium for Windows

### 🚀 Greater System Efficiency

🧠 RAM Compression — keeps things smooth when multitasking \
⚙️ Foreground Boost — gives priority to apps you’re actually using \
🌐 Network Turbo — better throughput, lower latency \
🌱 EnergyStarX + EcoQoS — smartly throttles background stuff to save power \
📥 Free Download Manager — faster downloads & torrent support \
🔧 System Tweaks — optimized services, BCD, MMAgents, and registry settings for extra punch

### ☯️ A Beautifully Productive Environment

🗂️ Explorer Upgrades — smarter file handling; try Spacedrive for next-gen management! \
🎞️ Refined Animations — subtle, smooth, and never in your way \
🎨 Custom Rice — pre-tuned visuals & UI polish (no spoilers 👀) \
🔄 Seamless Updates — updates happen quietly,  disruption \
🚫 Decluttered Experience — no ads, no nags, no useless suggestions \
🖱️ Smooth Scrolling + Anti-Aliasing — crisp visuals and fluid navigation

### ♻️ Automated Maintenance & Management

🔄 Auto Updates + Drivers — installs & maintains what you need, hands-free \
🧩 Extra Drivers — adds optional utilities for better hardware support \
🧬 UEFI Smart Config — system optimizes BIOS/UEFI settings by itself \
💽 Drive Trimming — boosts SSD lifespan & read/write speed \
📊 Advanced Telemetry — contributes to faster Windows evolution

## ⚙️ Installation

### 🧩 Requirements

🧑‍💻 Administrator permissions \
🌐 Stable internet connection

### 💡 Suggestions

✅ Use Windows 10/11 (Activated) — Insider builds preferred for best results \
🦊 Replace default Edge: Run a trusted removal script and install Edge Canary — this ensures all apps open links in your browser of choice

### 🪟 Step-by-Step Installation

1️⃣ Open an elevated PowerShell

Press ⊞ Win → type “Terminal” → Ctrl + Shift + Enter \
Approve the UAC prompt by clicking Yes

2️⃣ Prepare the environment

Copy & paste the following into the new PowerShell window

```
Set-Location "$Env:windir\\Temp\\"
Remove-Item -Path "$env:windir\\Temp\\Fynelium-NT\\" -Recurse -Force
New-Item -Path "$env:windir\\Temp\\Fynelium-NT\\" -ItemType Directory -Force
winget install --id Git.Git -e --source winget
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine

```
🛈 If prompted for permission (first-time PowerShell use), type A and press Enter.

3️⃣ Clone & run the setup

Once Git is installed, open a new Terminal tab (so PowerShell refreshes its environment) and run:

```
git clone https://github.com/MrGrappleMan/Fynelium-NT.git $Env:windir\\Temp\\Fynelium-NT\\
Set-Location "$Env:windir\\Temp\\Fynelium-NT\\"
powershell "$Env:windir\\Temp\\Fynelium-NT\\script\\main.ps1"

```
⚡ What happens Next?

🧠 The first phase requires minimal manual input — just confirm a few things.
🛠️ After that, the script runs unattended to optimize system performance.
⚠️ Some harmless errors may appear — these are expected.
👀 Keep an eye on progress to ensure smooth execution.

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
