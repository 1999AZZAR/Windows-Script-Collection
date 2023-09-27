# PowerShell Script for Managing Firewall Rules

# Get the directory where this script is located
$scriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

# Ask the user whether to block or remove firewall rules
Write-Host "Choose an option:"
Write-Host "1. Block Firewall Rules"
Write-Host "2. Remove Firewall Rules"
$choice = Read-Host "Enter your choice (1/2): "

if ($choice -eq "1") {
    $action = "block"
    Write-Host "Blocking Firewall Rules..."
} elseif ($choice -eq "2") {
    $action = "remove"
    Write-Host "Removing Firewall Rules..."
} else {
    Write-Host "Invalid choice. Exiting script."
    exit
}

# Get all .exe files in the script's directory
$exeFiles = Get-ChildItem -Path $scriptDir -Filter *.exe

# Iterate through .exe files
foreach ($exeFile in $exeFiles) {
    $ruleName = "Blocked: $($exeFile.Name)"

    if ($action -eq "block") {
        # Add outbound and inbound firewall rules to block
        New-NetFirewallRule -Name $ruleName -Program $($exeFile.FullName) -Action Block -Direction Outbound
        New-NetFirewallRule -Name $ruleName -Program $($exeFile.FullName) -Action Block -Direction Inbound
        Write-Host "Firewall rules added for blocking: $($exeFile.FullName)"
    } elseif ($action -eq "remove") {
        # Remove outbound and inbound firewall rules
        Get-NetFirewallRule -Name $ruleName | Remove-NetFirewallRule -Force
        Write-Host "Firewall rules removed: $($exeFile.FullName)"
    }
}

Write-Host "Done"
