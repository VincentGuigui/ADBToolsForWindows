@echo off
@cd bin
if "%1" == "/?" GOTO HELP
if "%1" == "-?" GOTO HELP
if "%1" == "devices" GOTO devices
if "%1" == "connect" GOTO connect
if "%1" == "disconnect" GOTO disconnect

REM SHOW DEVICES
adb devices

set /p device_id=Enter Device ID:
if "%device_id%" == "" (adb tcpip 5555) ELSE (adb -s %device_id% tcpip 5555)
timeout /T 3

REM SHOW WLAN0 IP AND EXTRACT 
if "%device_id%" == "" (adb shell ip -f inet -o a|find "wlan0") ELSE (adb -s %device_id% shell ip -f inet -o a|find "wlan0")
if "%device_id%" == "" (FOR /f "tokens=4 delims=/ " %%G IN ('adb shell ip -f inet -o a^|find "wlan0"') DO set ip_address=%%G) 
if NOT "%device_id%" == "" (FOR /f "tokens=4 delims=/ " %%G IN ('adb -s %device_id% shell ip -f inet -o a^|find "wlan0"') DO set ip_address=%%G)
set /p ip_address_input=Enter IP address [%ip_address%]:
if NOT "%ip_address_input%" == "" set ip_address=%ip_address_input%

adb connect %ip_address%:5555
scrcpy -s %ip_address%:5555

adb -s %ip_address%:5555 usb
adb disconnect %ip_address%:5555

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
adb -s %2:5555 usb
adb disconnect %2:5555
GOTO END


:END
cd ..
