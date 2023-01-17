IF EXIST Start_WindowLess.vbs del Start_WindowLess.vbs
ECHO Set oShell = CreateObject ("Wscript.Shell") >> Start_WindowLess.vbs
ECHO Dim strArgs >> Start_WindowLess.vbs
ECHO strArgs = "cmd /c %*" >> Start_WindowLess.vbs
ECHO oShell.Run strArgs, 0, false >> Start_WindowLess.vbs
Start_WindowLess.vbs
del Start_WindowLess.vbs
