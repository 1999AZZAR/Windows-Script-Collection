# Function to set the TTL value
function Set-TTL {
    param (
        [int]$ttlValue
    )
    
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name DefaultTTL -Value $ttlValue
}

# Main menu
Write-Host "Choose TTL value:"
Write-Host "1. 64"
Write-Host "2. 128"
Write-Host "3. Custom"

$choice = Read-Host "Enter your choice (1/2/3):"

switch ($choice) {
    1 {
        Set-TTL 64
        Write-Host "TTL set to 64."
    }
    2 {
        Set-TTL 128
        Write-Host "TTL set to 128."
    }
    3 {
        $customTTL = Read-Host "Enter custom TTL value:"
        Set-TTL $customTTL
        Write-Host "TTL set to $customTTL."
    }
    default {
        Write-Host "Invalid choice. Please select 1, 2, or 3."
    }
}
