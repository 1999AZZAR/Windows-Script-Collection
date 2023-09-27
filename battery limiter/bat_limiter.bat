@echo off
set /p charge_level="Enter the desired battery charge percentage (between 50 and 100): "

:: Validate input
if %charge_level% LSS 50 (
    echo Invalid input! The minimum charge percentage is 50.
    pause
    exit /b 1
)

if %charge_level% GTR 100 (
    echo Invalid input! The maximum charge percentage is 100.
    pause
    exit /b 1
)

:: Set the maximum battery charge level using PowerShell
powershell -command "Set-ACBatterySetting -SettingId 5dd8f6e0-7d83-4c3e-bfcb-00b0c98b9b09 -Value %charge_level%"

:: Inform the user that the charge level has been set
echo Maximum battery charge level set to %charge_level%.
pause
