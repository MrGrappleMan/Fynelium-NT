// 🔱 Automated Handler
// → Executes each script in the Automated folder for automatically performing the tweaking process
// → Scripts that require zero user interaction, or can be made to be so, go in there
// → They are launched in parallel, hidden and elevated
// → Waits for completion of all with PID verification
// Exit codes: 0 = Success, 1 = No scripts found, 2 = Script failures, 3 = Timeout

use log::{error, info};
use simplelog::{Config, LevelFilter, WriteLogger};
use std::fs::{self, File};
use std::io::Write;
use std::path::Path;
use std::process::{Command, Stdio};
use std::thread;
use std::time::{Duration, SystemTime};
use sysinfo::{Pid, System};

fn main() {
    // Initialize logging
    let base_path = std::env::current_dir().expect("Failed to get current directory");
    let log_file_path = base_path.join("master_log.txt");
    let log_file = File::create(&log_file_path).expect("Failed to create log file");
    WriteLogger::init(LevelFilter::Info, Config::default(), log_file).expect("Failed to initialize logger");

    info!("⚙️ Initializing Master Orchestrator...");
    info!("Starting master execution...");

    // Configuration
    let timeout_secs = 300; // 5 minutes
    let script_extension = "ps1";
    let master_script = "_master.ps1";

    // Step 1: Gather all .ps1 scripts
    let scripts = match fs::read_dir(&base_path) {
        Ok(entries) => entries
            .filter_map(Result::ok)
            .filter(|entry| {
                entry.path().extension().and_then(|ext| ext.to_str()) == Some(script_extension)
                    && entry.path().file_name().and_then(|name| name.to_str()) != Some(master_script)
            })
            .map(|entry| entry.path())
            .collect::<Vec<_>>(),
        Err(e) => {
            error!("❌ Failed to read directory {}: {}", base_path.display(), e);
            std::process::exit(1);
        }
    };

    if scripts.is_empty() {
        error!("❌ No .{} scripts found in {}", script_extension, base_path.display());
        info!("No scripts found");
        std::process::exit(1);
    }

    // Step 2: Launch scripts in parallel
    let mut processes = Vec::new();
    for script_path in &scripts {
        let script_name = script_path.file_name().unwrap().to_string_lossy();
        println!("▶ Launching {}...", script_name);
        info!("Launching: {}", script_path.display());

        // Launch PowerShell process with elevated privileges
        let process = Command::new("powershell")
            .args(&[
                "-ExecutionPolicy",
                "Bypass",
                "-File",
                script_path.to_str().unwrap(),
            ])
            .creation_flags(0x08000000) // CREATE_NO_WINDOW
            .stdout(Stdio::null())
            .stderr(Stdio::null())
            .spawn();

        match process {
            Ok(child) => {
                processes.push((script_name.to_string(), child.id()));
            }
            Err(e) => {
                error!("⚠ Failed to launch {}: {}", script_name, e);
                info!("Failed to launch: {} - Error: {}", script_path.display(), e);
            }
        }
    }

    // Step 3: Monitor process completion
    println!("\n⏳ Waiting for all subscripts to finish...");
    let start_time = SystemTime::now();
    let mut running = processes.iter().map(|(name, pid)| (name.clone(), *pid, "Running".to_string())).collect::<Vec<_>>();

    loop {
        // Check for timeout
        if let Ok(elapsed) = start_time.elapsed() {
            if elapsed.as_secs() > timeout_secs {
                error!("❌ Timeout: Some scripts did not complete within {} seconds!", timeout_secs);
                info!("Timeout occurred");
                std::process::exit(3);
            }
        }

        let mut system = System::new_all();
        system.refresh_all();

        let all_completed = running.iter_mut().all(|(name, pid, status)| {
            if status != "Completed" {
                if !system.process(Pid::from(*pid as usize)).is_some() {
                    println!("✅ {} has finished.", name);
                    info!("Completed: {}", name);
                    *status = "Completed".to_string();
                }
            }
            status == "Completed"
        });

        if all_completed {
            break;
        }

        thread::sleep(Duration::from_secs(1));
    }

    // Step 4: Cleanup and Verification
    println!("\n🔍 Verifying completion...");
    let mut failed = Vec::new();

    for (name, pid, status) in &running {
        if status == "Running" {
            if let Some(process) = System::new_all().process(Pid::from(*pid as usize)) {
                process.kill();
                println!("🛑 Terminated hung process for {}", name);
                info!("Terminated hung process: {}", name);
            }
            failed.push(name.clone());
        }
    }

    if !failed.is_empty() {
        error!("❌ Some scripts failed or never reported completion: {}", failed.join(", "));
        info!("Failures detected: {}", failed.join(","));
        std::process::exit(2);
    } else {
        println!("✅ All scripts completed successfully!");
        info!("All scripts completed successfully.");
    }
}
