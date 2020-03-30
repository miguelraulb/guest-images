echo ==^> Installing updates

DISM /Online /Enable-Feature /FeatureName:NetFx3 /NoRestart

set DISK=d:\

:: Apply updates for Windows 7
ver | find "6.1" > nul
if not %ERRORLEVEL% == 0 goto not7

if exist "%SystemDrive%\Program Files (x86)" (
    set UPDATES_DIR=%DISK%\win7_updates\x64
    set ARCH=x64
) else (
    set UPDATES_DIR=%DISK%\win7_updates\x86
    set ARCH=x86
)

:: Only install first batch of updates here.
:: It's not possible to install all updates because reboots are required.
for %%f in (%UPDATES_DIR%\01*.msu) do (
    echo Installing %%f
    start /wait wusa.exe %%f /quiet /norestart
)

:not7
