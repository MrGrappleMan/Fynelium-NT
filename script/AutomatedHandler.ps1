# 🔱 Automated Handler
# → Executes each script in the Automated folder for automatically performing the tweaking process
# → Scripts that require zero user interaction, or can be made to be so, go in there
# → They are launched in parallel, hidden and elevated
# → Waits for completion of all with PID verification

$basePath = "C:\Windows\Temp\Fynelium-NT\script\Automated\"
$logFile  = "$basePath\master_log.txt"
$ErrorActionPreference = "Continue"

Write-Host "⚙️ Initializing Master Orchestrator..." -ForegroundColor Cyan
"[$(Get-Date)] Starting master execution..." | Out-File $logFile -Append

# --- 1️⃣ Gather all subscripts ---
$scripts = Get-ChildItem -Path $basePath -Filter "*.ps1" -File | Where-Object { $_.Name -ne "_master.ps1" }

if (-not $scripts) {
	Write-Host "❌ No .ps1 scripts found in $basePath"
	exit 1
}

# --- 2️⃣ Launch all scripts in parallel (Hidden, Elevated) ---
$jobs = @()
foreach ($script in $scripts) {
	$scriptPath = $script.FullName
	Write-Host "▶ Launching $($script.Name)..."
	"[$(Get-Date)] Launching: $scriptPath" | Out-File $logFile -Append

	$process = Start-Process powershell `
		-ArgumentList "-ExecutionPolicy Bypass -File `"$scriptPath`"" `
		-WindowStyle Hidden -Verb RunAs -PassThru

	if ($process) {
		$jobs += [PSCustomObject]@{
			Name    = $script.Name
			PID     = $process.Id
			Process = $process
			Status  = "Running"
		}
	} else {
		Write-Host "⚠ Failed to launch $($script.Name)"
	}
}

# --- 3️⃣ Monitor completion of all PIDs ---
Write-Host "`n⏳ Waiting for all subscripts to finish..."
while ($true) {
	foreach ($job in $jobs) {
		try {
			if (-not (Get-Process -Id $job.PID -ErrorAction SilentlyContinue)) {
				if ($job.Status -ne "Completed") {
					Write-Host "✅ $($job.Name) has finished."
					$job.Status = "Completed"
					"[$(Get-Date)] Completed: $($job.Name)" | Out-File $logFile -Append
				}
			}
		} catch {
			# Ignore missing processes
		}
	}

	if ($jobs.Status -notcontains "Running") { break }
	Start-Sleep -Seconds 3
}

# --- 4️⃣ Verification (simple or custom check) ---
Write-Host "`n🔍 Verifying completion..."
$failed = @()

foreach ($job in $jobs) {
	if ($job.Status -ne "Completed") {
		$failed += $job.Name
	}
}

if ($failed.Count -gt 0) {
	Write-Host "❌ Some scripts failed or never reported completion:" -ForegroundColor Red
	$failed | ForEach-Object { Write-Host "   • $_" -ForegroundColor DarkRed }
	"[$(Get-Date)] Failures detected: $($failed -join ', ')" | Out-File $logFile -Append
	exit 2
} else {
	Write-Host "✅ All scripts completed successfully!"
	"[$(Get-Date)] All scripts completed successfully." | Out-File $logFile -Append
}
