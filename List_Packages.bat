@echo off
set adb=bin\win64\adb

set /p filter=Filter (package name or keyword) ? 
if "%filter%" NEQ "" (
	%adb% shell cmd package list packages | findstr -i %filter%
) ELSE (
	%adb% shell cmd package list packages
)
pause