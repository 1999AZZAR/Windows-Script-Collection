@echo off
setlocal enabledelayedexpansion

echo Choose TTL value:
echo 1. 64
echo 2. 128
echo 3. Custom

set /p choice=Enter your choice (1/2/3): 

if "%choice%"== "1" (
  reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 64 /f
  echo TTL set to 64.
) elseif "%choice%"== "2" (
  reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 128 /f
  echo TTL set to 128.
) elseif "%choice%"== "3" (
  set /p custom_ttl=Enter custom TTL value: 
  reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d !custom_ttl! /f
  echo TTL set to !custom_ttl!.
) else (
  echo Invalid choice. Please select 1, 2, or 3.
)

pause
