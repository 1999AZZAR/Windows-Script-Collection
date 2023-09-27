@echo off
setlocal enabledelayedexpansion

:: Get the directory where this script is located
for %%i in ("%~dp0.") do set "script_dir=%%~fi"

:: Ask the user whether to block or remove firewall rules
echo Choose an option:
echo 1. Block Firewall Rules
echo 2. Remove Firewall Rules
set /p choice="Enter your choice (1/2): "

if "%choice%"=="1" (
    set action=block
    echo Blocking Firewall Rules...
) else if "%choice%"=="2" (
    set action=remove
    echo Removing Firewall Rules...
) else (
    echo Invalid choice. Exiting script.
    exit /b 1
)

:: Iterate through .exe files in the script's directory
for %%f in ("%script_dir%\*.exe") do (
    set "file=%%f"
    set "ruleName=Blocked: !file:%script_dir%\=!"
    
    if "%action%"=="block" (
        :: Add outbound and inbound firewall rules to block
        netsh advfirewall firewall add rule name="%ruleName%" program="!file!" dir=out action=block
        netsh advfirewall firewall add rule name="%ruleName%" program="!file!" dir=in action=block
        echo Firewall rules added for blocking: !file!
    ) else if "%action%"=="remove" (
        :: Remove outbound and inbound firewall rules
        netsh advfirewall firewall delete rule name="%ruleName%" program="!file!" dir=out
        netsh advfirewall firewall delete rule name="%ruleName%" program="!file!" dir=in
        echo Firewall rules removed: !file!
    )
)

echo Done
pause
