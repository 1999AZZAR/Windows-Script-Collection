# Prompt the user for the desired battery charge percentage
$charge_level = Read-Host "Enter the desired battery charge percentage (between 50 and 100): "

# Validate input
if ($charge_level -lt 50 -or $charge_level -gt 100) {
    Write-Host "Invalid input! The charge percentage must be between 50 and 100."
    exit 1
}

# Set the maximum battery charge level
$settingId = "5dd8f6e0-7d83-4c3e-bfcb-00b0c98b9b09"
powercfg -SETACVALUEINDEX $settingId 1 $charge_level

# Apply the changes
powercfg -S $settingId

Write-Host "Maximum battery charge level set to $charge_level%."
