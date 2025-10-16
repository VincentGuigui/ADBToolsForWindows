@ECHO off
set devices="phone" "quest1" "quest2" "quest3" "quest3s" "rhinox2"
set connections="usb" "wifi"
set actions="devices" "network" "view_usb" "view_wifi" "disconnect"
set all_params=%devices% %connections% %actions%

echo:
echo VIEW_SCREEN - v1.3 - https://github.com/VincentGuigui/ADBToolsForWindows
echo View the screen of you android devices (phone and HMD) using USB or Wi-Fi
echo:

if "%PROCESSOR_ARCHITECTURE%" == "x86" (
	set "PATH=%PATH%;%cd%\bin\win32"
) ELSE (
	set "PATH=%PATH%;%cd%\bin\win64"
)
SET NEXT_GOTO=END

IF /I "%1" == "/?" GOTO HELP
IF /I "%1" == "-?" GOTO HELP

:ARGS_MANAGEMENT
SET DEVICE_ARG=
FOR %%G IN (%devices%) DO (IF /I "%1" == %%G SET DEVICE_ARG=%1)
FOR %%G IN (%devices%) DO (IF /I "%2" == %%G SET DEVICE_ARG=%2)
FOR %%G IN (%devices%) DO (IF /I "%3" == %%G SET DEVICE_ARG=%3)
SET CONNECTION_ARG=
FOR %%G IN (%connections%) DO (IF /I "%1" == %%G SET CONNECTION_ARG=%1)
FOR %%G IN (%connections%) DO (IF /I "%2" == %%G SET CONNECTION_ARG=%2)
FOR %%G IN (%connections%) DO (IF /I "%3" == %%G SET CONNECTION_ARG=%3)
SET ACTION_ARG=
FOR %%G IN (%actions%) DO (IF /I "%1" == %%G SET ACTION_ARG=%1)
FOR %%G IN (%actions%) DO (IF /I "%2" == %%G SET ACTION_ARG=%2)
FOR %%G IN (%actions%) DO (IF /I "%3" == %%G SET ACTION_ARG=%3)

SET DEVICE_ID=%1
FOR %%G IN (%devices% %connections% %actions%) DO (IF /I "%DEVICE_ID%" == %%G SET DEVICE_ID=)
IF /I "%DEVICE_ID%" == "" (
	SET DEVICE_ID=%2
	FOR %%G IN (%devices% %connections% %actions%) DO (IF /I "%DEVICE_ID%" == %%G SET DEVICE_ID=)
	IF /I "%DEVICE_ID%" == "" (
		SET DEVICE_ID=%3
		FOR %%G IN (%devices% %connections% %actions%) DO (IF /I "%DEVICE_ID%" == %%G SET DEVICE_ID=)
		)
	)

IF "%DEVICE_ARG%" == "" (
	SET NEXT_GOTO=ARGS_MANAGEMENT_ACTION_NEXT
	FOR %%G IN ("" "view_usb" "view_wifi") DO (IF /I "%ACTION_ARG%" == %%G GOTO SELECT_DEVICE_TYPE)
	)
	
:ARGS_MANAGEMENT_ACTION_NEXT
FOR %%G IN ("network" "view_wifi" "disconnect") DO (IF /I "%ACTION_ARG%" == %%G SET CONNECTION_ARG=WIFI)
FOR %%G IN ("view_usb") DO (IF /I "%ACTION_ARG%" == %%G SET CONNECTION_ARG=USB)
IF "%CONNECTION_ARG%" == "" (
	SET NEXT_GOTO=ARGS_MANAGEMENT_CONNECTION_NEXT
	IF "%ACTION_ARG%" == "" GOTO SELECT_CONNECTION_TYPE
	)
	
:ARGS_MANAGEMENT_CONNECTION_NEXT

IF /I "%DEVICE_ARG%" == "phone" SET SCRCPY_ARGS=
IF /I "%DEVICE_ARG%" == "quest1" SET SCRCPY_ARGS=--crop 1280:720:1500:350 
IF /I "%DEVICE_ARG%" == "quest2" SET SCRCPY_ARGS=--crop 1600:900:2017:510
IF /I "%DEVICE_ARG%" == "quest3s" SET SCRCPY_ARGS=--crop 1600:900:2017:510
IF /I "%DEVICE_ARG%" == "quest3" SET SCRCPY_ARGS=--crop=2744:1544:0:0 --angle=22 -b 16M 
IF /I "%DEVICE_ARG%" == "rhinox2" SET SCRCPY_ARGS=--crop=700:1000:200:350 --capture-orientation=270

ECHO 	ACTION_ARG=%ACTION_ARG%
ECHO 	CONNECTION_ARG=%CONNECTION_ARG%
ECHO 	DEVICE_ARG=%DEVICE_ARG%
ECHO 	DEVICE_ID=%DEVICE_ID%
IF NOT "%DEVICE_ID%" == "" SET DEVICE_ID=-s %DEVICE_ID%
ECHO 	SCRCPY_ARGS=%SCRCPY_ARGS%

SET NEXT_GOTO=END
IF /I "%ACTION_ARG%" == "devices" GOTO ACTION_DEVICES
IF /I "%ACTION_ARG%" == "network" GOTO ACTION_NETWORK
IF /I "%ACTION_ARG%" == "view_usb" GOTO ACTION_VIEW_USB
IF /I "%ACTION_ARG%" == "view_wifi" GOTO ACTION_VIEW_WIFI
IF /I "%ACTION_ARG%" == "disconnect" GOTO ACTION_DISCONNECT
GOTO MAIN

:SELECT_DEVICE_TYPE
ECHO Select your device:
ECHO P:Phone
ECHO 1:Oculus Quest 1
ECHO 2:Oculus Quest 2
ECHO 3:Oculus Quest 3
ECHO S:Oculus Quest 3S
ECHO X:Rhino X2
choice /C P123SX /D P /T 5
IF /I "%ERRORLEVEL%" == "6" SET DEVICE_ARG=rhinox2
IF /I "%ERRORLEVEL%" == "5" SET DEVICE_ARG=quest3s
IF /I "%ERRORLEVEL%" == "4" SET DEVICE_ARG=quest3
IF /I "%ERRORLEVEL%" == "3" SET DEVICE_ARG=quest2
IF /I "%ERRORLEVEL%" == "2" SET DEVICE_ARG=quest1
IF /I "%ERRORLEVEL%" == "1" SET DEVICE_ARG=phone
GOTO %NEXT_GOTO%

:SELECT_CONNECTION_TYPE
ECHO How do you want to connect ?
ECHO W:WiFi
ECHO U:USB
choice /C WU /D U /T 5
IF /I "%ERRORLEVEL%" == "2" SET CONNECTION_ARG=USB
IF /I "%ERRORLEVEL%" == "1" SET CONNECTION_ARG=WIFI
GOTO %NEXT_GOTO%

:SELECT_DEVICE
REM TEST IF THERE ARE MORE THAN ONE DEVICES
IF NOT "%DEVICE_ID%" == "" GOTO %NEXT_GOTO%
adb shell cd
IF /I "%ERRORLEVEL%" == "0" GOTO %NEXT_GOTO%
adb devices
FOR /F %%G IN ('adb devices ^|find "	device"') DO SET device_id=%%G
SET count_devices=0
FOR /F %%G IN ('adb devices ^|find "	device"') DO SET /A count_devices=count_devices+1
IF "%count_devices%" == "0" (
	ECHO No device connected
	GOTO END
	)
IF "%count_devices%" == "1" GOTO %NEXT_GOTO%
SET /p device_id=Enter Device ID [%device_id%]:
IF NOT "%DEVICE_ID%" == "" SET DEVICE_ID=-s %DEVICE_ID%
GOTO %NEXT_GOTO%

:SELECT_IP_ADDRESS
IF "%count_ipaddresses%" == "1" ECHO Connecting to %ip_address%...
IF "%count_ipaddresses%" == "1" GOTO %NEXT_GOTO%
SET /p ip_address=Enter IP address [%ip_address%]:
REM IF NOT "%ip_address_input%" == "" SET ip_address=%ip_address_input%
GOTO %NEXT_GOTO%

:HELP
ECHO Connect and mirror Android device onto Windows
ECHO View_Screen.bat [action,connection] [device_type] [device_id,ip_address]
ECHO Using View_Screen.bat without any parameter will prompt for missing parameters
ECHO [action]
ECHO   (nothing)   execute all the commands step by step with interactive prompts
ECHO   devices     Show list of connected devices
ECHO   network     Retrieve network info for a USB device and enable Wifi connection
ECHO   view_usb    Start mirroring a connected device in USB
ECHO   view_wifi   Start mirroring a connected device in WiFi (network must have been done previously)
ECHO   disconnect  Interrupt network connection
ECHO [connection]
ECHO   usb         force all commands to use USB mode
ECHO   wifi        force all commands to use WiFi mode
ECHO [device_type] adjust the mirroring CROP (resolution and offset)
ECHO   phone       full mirroring
ECHO   quest1      mirror only one eye with Quest 1 resolution
ECHO   quest2      mirror only one eye with Quest 2 resolution
ECHO   quest3      mirror only one eye with Quest 3 resolution
ECHO   quest3s      mirror only one eye with Quest 3S resolution
ECHO [device_id]   Specify the device ID if you know it
ECHO   (nothing)   Devices IDs will be displayed and prompt if more than one device is connected
ECHO #################
ECHO # Main commands #
ECHO #################
ECHO View_Screen.bat (interactive mode)
ECHO View_Screen.bat usb [phone,quest1,quest2] [device_id] 
ECHO View_Screen.bat wifi [phone,quest1,quest2] [device_id]  
ECHO View_Screen.bat devices
ECHO View_Screen.bat network [device_id]
ECHO View_Screen.bat view_usb [phone,quest1,quest2] [device_id,ip_address]
ECHO View_Screen.bat view_wifi [phone,quest1,quest2] [device_id,ip_address]
ECHO View_Screen.bat disconnect ip_address
ECHO 	eg: to enable a WiFi mirroring from a phone already connected in USB
ECHO 		View_Screen.bat wifi phone 988919474e34594255
GOTO END

:ACTION_DEVICES
:DEVICES
adb devices
GOTO %NEXT_GOTO%

:ACTION_NETWORK

:NETWORK
REM SHOW WLAN0 IP AND EXTRACT 
adb %device_id% tcpip 5555
timeout /T 5
GOTO GET_IP_ADDRESSES

:GET_IP_ADDRESSES
adb %device_id% shell ip -f inet -o a|find "wlan0"
FOR /f "tokens=4 delims=/ " %%G IN ('adb %device_id% shell ip -f inet -o a^|find "wlan0"') DO SET ip_address=%%G
SET count_ipaddresses=0
FOR /f "tokens=4 delims=/ " %%G IN ('adb %device_id% shell ip -f inet -o a^|find "wlan0"') DO SET /A count_ipaddresses=%count_ipaddresses%+1
ECHO %count_ipaddresses% IP addresses have been found. Default will be '%ip_address%'
GOTO %NEXT_GOTO%

:ACTION_VIEW_USB
SET NEXT_GOTO=ACTION_VIEW_USB_NEXT
GOTO SELECT_DEVICE
:ACTION_VIEW_USB_NEXT
SET NEXT_GOTO=END
GOTO VIEW_USB

:ACTION_VIEW_WIFI
SET NEXT_GOTO=ACTION_VIEW_WIFI_SET_IP
GOTO GET_IP_ADDRESSES
:ACTION_VIEW_WIFI_SET_IP
SET NEXT_GOTO=ACTION_VIEW_WIFI_NEXT
GOTO SELECT_IP_ADDRESS
:ACTION_VIEW_WIFI_NEXT
SET NEXT_GOTO=END
GOTO VIEW_WIFI

:ACTION_DISCONNECT
SET NEXT_GOTO=ACTION_DISCONNECT_SET_IP
GOTO GET_IP_ADDRESSES
:ACTION_DISCONNECT_SET_IP
SET NEXT_GOTO=ACTION_DISCONNECT_NEXT
GOTO SELECT_IP_ADDRESS
:ACTION_DISCONNECT_NEXT
SET NEXT_GOTO=END
GOTO DISCONNECT

:VIEW_USB
IF /I "%device_id%" == "" (scrcpy %SCRCPY_ARGS%) ELSE (scrcpy %SCRCPY_ARGS% %device_id%)
GOTO %NEXT_GOTO%

:VIEW_WIFI
adb connect %ip_address%:5555
REM if /I "%DEVICE_ARG%" == "quest3" (set SCRCPY_ARGS=%SCRCPY_ARGS% -max-fps 15 -b 1M --max-size 1080 --display-buffer 100)
scrcpy %SCRCPY_ARGS% -s %ip_address%:5555
GOTO %NEXT_GOTO%

:DISCONNECT
adb -s %ip_address%:5555 usb
adb disconnect %ip_address%:5555
GOTO %NEXT_GOTO%

REM ########################################
REM #  MAIN SEQUENCE WITH A LOT OF GO SUB  #
REM ########################################
:MAIN

SET NEXT_GOTO=MAIN_USB_BYPASS
IF /I "%CONNECTION_ARG%" == "USB" GOTO SELECT_DEVICE

:MAIN_USB_BYPASS
SET NEXT_GOTO=END
IF /I "%CONNECTION_ARG%" == "USB" GOTO VIEW_USB

:MAIN_SHOW_DEVICES
SET NEXT_GOTO=MAIN_SELECT_DEVICE
GOTO DEVICES

:MAIN_SELECT_DEVICE
SET NEXT_GOTO=MAIN_CONNECTION
GOTO SELECT_DEVICE

:MAIN_CONNECTION
SET NEXT_GOTO=MAIN_SELECT_IP
GOTO NETWORK

:MAIN_SELECT_IP
SET NEXT_GOTO=MAIN_VIEW
GOTO SELECT_IP_ADDRESS

:MAIN_VIEW
SET NEXT_GOTO=MAIN_DISCONNECT_CHOICE
GOTO VIEW_WIFI

:MAIN_DISCONNECT_CHOICE
IF /I "%CONNECTION_ARG%" == "WIFI" (	
	choice /M "Do you want to stop the WiFi connection between the device and the computer ?"
	IF /I "%ERRORLEVEL%" == "2" GOTO END
	SET NEXT_GOTO=END
	GOTO DISCONNECT
	)
GOTO END

:END
