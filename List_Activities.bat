@echo off
set adb=bin\win64\adb

set /p packagename=Package name ? 
set /p filter=Filter (intent or activity name) ? 
if "%filter%" NEQ "" (
	%adb% shell dumpsys package %packagename% | findstr -i %filter%
) ELSE (
	%adb% shell dumpsys package %packagename%
)
pause