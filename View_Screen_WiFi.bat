@echo off
@cd bin
if "%1" == "/?" GOTO HELP
if "%1" == "-?" GOTO HELP
if "%1" == "devices" GOTO devices
if "%1" == "connect" GOTO connect
if "%1" == "disconnect" GOTO disconnect

adb devices
set /p device_id=Enter Device ID:
adb -s %device_id% tcpip 5555
timeout /T 2
adb -s %device_id% shell ip -f inet -o a
set /p ip_address=Enter IP address:
adb connect %ip_address%:5555
scrcpy -s %ip_address%:5555
GOTO END

:HELP
echo View_Screen_WiFi.bat devices
echo View_Screen_WiFi.bat network device_id
echo View_Screen_WiFi.bat connect ip_address
echo View_Screen_WiFi.bat disconnect ip_address
GOTO END

:DEVICES
adb devices
GOTO END

:NETWORK
adb -s %2 tcpip 5555
adb -s %2 shell ip -f inet -o a
GOTO END

:CONNECT
adb connect %2:5555
scrcpy -s %2:5555
GOTO END

:DISCONNECT
adb disconnect %2:5555
GOTO END


:END
cd ..
