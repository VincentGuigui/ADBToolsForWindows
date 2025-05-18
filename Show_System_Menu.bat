@echo off
set adb=bin\win64\adb

ECHO Which menu do you want to display:
ECHO G:General settings
ECHO A:About device / device info / version
ECHO S:System menu (to access the about menu)
ECHO D:Developer menu
choice /C GASD /D G /T 5

echo Launching menu

IF /I "%ERRORLEVEL%" == "4" %adb% shell am start -n com.android.settings/.Settings\$DevelopmentSettingsDashboardActivity
IF /I "%ERRORLEVEL%" == "3" %adb% shell am start -n com.android.settings/.Settings\$MyDeviceInfoActivity
IF /I "%ERRORLEVEL%" == "2" %adb% shell am start -n com.android.settings/.Settings\$SystemDashboardActivity
IF /I "%ERRORLEVEL%" == "1" %adb% shell am start -n com.android.settings/.Settings

pause