# Fynelium for Windows

## Features

### 1. 🚀 Better performance

1. Avoid virtual memory and enable ZRAM
2. Subtler animations
3. Exclusive Tweaks for High Performance and Gaming

### 2. ☯️ Productive environment

1. File Explorer tweaks for better file handling
2. Make UI responsive with priority over background processes
3. [Komorebi rice 🍉](https://lgug2z.github.io/komorebi/)
4. Updates interfere less with your experience
5. Abstraction of unnecessary information
6. Avoid suggestions
7. Smooth scrolling
8. UI Text anti-aliasing

### 3. ♻️ Automatic Management of all sorts

1. Updates handled automatically
2. Drivers are handled as per modern algorithms
3. Windows' engine handles UEFI setup utility settings for itself for optimal performance
4. Drive trimming
5. Advanced Telemetry to help Microsoft developers

This is for users who want to have a better Windows experience.

## Installation

Search for Terminal, press Ctrl+Shift+Enter.
Paste the text below into the newly launched window.

```
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
Remove-Item -Path "$env:windir\\Temp\\Fynelium-NT\\" -Recurse -Force
New-Item -Path "$env:windir\\Temp\\Fynelium-NT\\" -ItemType Directory -Force
winget install --id Git.Git -e --source winget
git clone <https://github.com/MrGrappleMan/Fynelium-NT.git> %windir%\\Temp\\Fynelium-NT\\
%windir%\\Temp\\Fynelium-NT\\script\\main.ps1
```
You will be prompted for an input. Type the letter "a" or ”A” and hit enter.

## [Advanced Documentation](https://www.notion.so/Windows-27642d161cf980b395c2fbbd1d1f70ae?source=copy_link)
