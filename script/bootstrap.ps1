# bootstrap.ps1 — One-line installer for Fynelium-NT

# Ensure admin rights
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
	powershell irm https://raw.githubusercontent.com/MrGrappleMan/Fynelium-NT/main/script/bootstrap.ps1 | iex
	exit
}

# Create temp directory
$path = "$env:windir\Temp\Fynelium-NT\"
if (Test-Path $path) { Remove-Item $path -Recurse -Force }
New-Item -Path $path -ItemType Directory -Force | Out-Null

# Ensure Git is present
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
	Write-Host "Installing Git via winget..." -ForegroundColor Cyan
	winget install --id Git.Git -e --source winget
	Write-Host "Git installation completed. Refreshing environment variables..." -ForegroundColor Yellow

	# Refresh environment variables (PATH)
	$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
	             [System.Environment]::GetEnvironmentVariable("Path", "User")

	# Double-check Git availability after refresh
	if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
		Write-Host "Restarting PowerShell to load Git into PATH..." -ForegroundColor Cyan
		Start-Process "powershell" -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
		exit
	}
}

# Clone repo & execute main script
git clone https://github.com/MrGrappleMan/Fynelium-NT.git $path
Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$path\script\main.ps1`"" -Verb RunAs
