@echo off
cd bin
echo Enabling USB on the device
adb shell svc usb setFunctions mtp,adb true
echo ...
ping 127.0.0.1 >nul
echo ...
ping 127.0.0.1 >nul
echo Verification: "mtp,adb" should appear here:
adb shell svc usb getFunctions
echo Press any key to close this window
pause>nul