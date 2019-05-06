@echo off
REM Batch script is used to call scripts.ps1

cd "%~dp0"
%WinDir%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -NoLogo -ExecutionPolicy Unrestricted -File "%~dp0startup_extra_scripts.ps1" %*
exit /b
