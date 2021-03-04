@echo off
cd bin
echo Enabling USB on the device
adb shell svc usb setFunction mtp true
echo ...
ping 127.0.0.1 >nul
echo ...
ping 127.0.0.1 >nul
echo Veryfy "mtp,adb" should appear here:
adb shell svc usb getFunction
echo Press any key to close this window
pause>nul