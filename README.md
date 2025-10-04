![Last Commit made to repository](https://img.shields.io/github/last-commit/MrGrappleMan/Fynelium-NT?style=for-the-badge)

# Fynelium for Windows
Suggested specs: Windows 11 with Beta insider channel or deeper

### 1. 🚀 Better performance

1. Avoid virtual memory and enable ZRAM
2. Subtler animations
3. Exclusive Tweaks for High Performance and Gaming

### 2. ☯️ Productive environment

1. File Explorer tweaks for advanced file handling
2. Make UI responsive with priority over background processes
3. [Komorebi rice 🍉](https://lgug2z.github.io/komorebi/)
4. Updates interfere less with your experience
5. Abstraction of unnecessary information
6. Avoid suggestions and advertisements
7. Smooth scrolling and minor anti-aliasing

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
cd "$Env:windir\\Temp\\"
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
Remove-Item -Path "$env:windir\\Temp\\Fynelium-NT\\" -Recurse -Force
New-Item -Path "$env:windir\\Temp\\Fynelium-NT\\" -ItemType Directory -Force
winget install --id Git.Git -e --source winget
git clone https://github.com/MrGrappleMan/Fynelium-NT.git $Env:windir\\Temp\\Fynelium-NT\\
cd "$Env:windir\\Temp\\Fynelium-NT\\"
powershell "$Env:windir\\Temp\\Fynelium-NT\\script\\main.ps1"

```
You may be prompted for an input by powershell. In that case, type the letter "a" or ”A” and hit enter.

### [Extra Documentation](https://www.notion.so/Windows-27642d161cf980b395c2fbbd1d1f70ae?source=copy_link)
