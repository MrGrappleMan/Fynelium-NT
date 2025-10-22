# bootstrap.ps1 — One-line installer for Fynelium-NT

# Ensure admin rights
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
	Write-Host "Please run this script as Administrator." -ForegroundColor Red
  Read-Host
	exit
}

# Create temp directory
$path = "$env:windir\Temp\Fynelium-NT\"
if (Test-Path $path) { Remove-Item $path -Recurse -Force }
New-Item -Path $path -ItemType Directory -Force | Out-Null

# Ensure Git is available
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
	Write-Host "Installing Git via winget..." -ForegroundColor Cyan
	winget install --id Git.Git -e --source winget
	Start-Sleep -Seconds 5
}

# Clone repo & execute main script
git clone https://github.com/MrGrappleMan/Fynelium-NT.git $path
Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$path\script\main.ps1`"" -Verb RunAs
