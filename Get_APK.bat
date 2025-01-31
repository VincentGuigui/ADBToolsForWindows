@echo off

adb shell cmd package list packages | find /V ":com.oculus" | find /V ":com.android" | find /V ":com.facebook" | find /V ":oculus.platform" | find /V ":com.meta" | find /V ":android" | find /V ":horizonos" | find /V ":com.qualcomm" | find /V ":com.whatsapp" > %temp%\apk.lst

for /f "tokens=2 delims=:" %%A in ('type %temp%\apk.lst') do echo %%A
set /p packagename=APK Package Name: 
adb shell pm path %packagename%
FOR /f "tokens=2 delims=:" %%K IN ('adb shell pm path %packagename%') DO set APK=%%K

setlocal EnableExtensions DisableDelayedExpansion

set "Reg32=%SystemRoot%\System32\reg.exe"
if not "%ProgramFiles(x86)%" == "" set "Reg32=%SystemRoot%\SysWOW64\reg.exe"

set "DownloadShellFolder="
for /F "skip=1 tokens=1,2*" %%T in ('%Reg32% query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" 2^>nul') do (
    if /I "%%T" == "{374DE290-123F-4565-9164-39C4925E467B}" (
        set "DownloadShellFolder=%%V"
    )
)
echo Downloading APK to %DownloadShellFolder%
adb pull %APK% "%DownloadShellFolder%\%packagename%.apk"
