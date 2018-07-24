@echo off
rem
rem .bashrc for cmd.exe
rem link it from:
rem     %USERPROFILE%\.cmdrc.cmd
rem to enable it:
rem     REG add "HKCU\Software\Microsoft\Command Processor" /v "AutoRun" /d "%USERPROFILE%\.cmdrc.cmd" /f
rem

set NVS_DIR=%USERPROFILE%\nvs
if exist %NVS_DIR%\nvs.cmd call %NVS_DIR%\nvs.cmd
