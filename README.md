# ADBToolsForWindows
Portable version of ADB and .bat files for everyday development/debugging of Android devices (based on Genymobile binaries)


# Features
* access Android device as USB drive
* enable screen copy/mirroring through USB
* enable screen copy/mirroring through WiFi 
* install APK application though USB 

  
# FAQ

## How to install an APK using command line or drag&drop ?
2 solutions:
- If the screen copy window is already open, you can drag drop your APK file directly to this window
- Alternatively you can drag drop the APK onto the **"Install Application.bat"** file

## How to mirror / screen copy my Android device on Windows ?
Android device like phone (Samsung, HTC, Xiaomi, Huawei, ...), Smartglasses (Vuzix, Realwear...) can be mirrored to Windows
Internally we are using [Genymobile scrcpy](https://github.com/Genymobile/scrcpy)

If the device is connected to any USB port of your computer, just double-click on **"View Screen.bat"**

If you want to mirror your Android device wirelessly, just read the next part.

## How to mirror / screen copy my Android device using Wireless on Windows ?
You can stream / mirror you  Android device to any Windows on the same WiFi network.
- First, plug your device to a USB port of your computer
- **Double-click** on **"View Screen WiFi.bat"**
- *(The list of all Android connected devices will be shown)*
- **Copy/Paste the name of the device** you want to connect to
  - With your mouse, *select the name* of the device
  - *Right-Click twice* (first to copy, then to paste it)
- Press **Enter** (or correct any irrelevant character)
- *(The script will activate the TCPIP mode on the device)*
- *(The IP address of the device will be shown, eg: 192.168.1.XX)*
- **Copy/Paste the IP address**
  - With your mouse, *select the IP Address* of the device
  - *Right-Click twice* (first to copy, then to paste it)
- Press **Enter** (or correct any irrelevant character)
- Enjoy

You must have something like that:

```
C:\ADBToolsForWindows>View_Screen_WiFi.bat

List of devices attached
988919474e34594249      device
192.168.1.50:5555       device

Enter Device ID:988919474e34594249
restarting in TCP mode port: 5555

Attendre 0 secondes, appuyez sur une touche pour continuer...
1: lo    inet 127.0.0.1/8 scope host lo\       valid_lft forever preferred_lft forever
14: wlan0    inet 192.168.1.19/24 brd 192.168.1.255 scope global wlan0\       valid_lft forever preferred_lft forever
Enter IP address:192.168.1.19
connected to 192.168.1.19:5555
INFO: scrcpy 1.17 <https://github.com/Genymobile/scrcpy>
C:\ADBToolsForWindows\bin\scrcpy-serv...e pushed, 0 skipped. 24.3 MB/s (34930 bytes in 0.001s)
[server] INFO: Device: samsung SM-G950F (Android 9)
INFO: Renderer: direct3d
INFO: Initial texture: 720x1480

C:\ADBToolsForWindows\bin>
```

You can type "**View_Screen_WiFi.bat /?**" on the command line to get more options:
```
View_Screen_WiFi.bat devices
View_Screen_WiFi.bat network device_id
View_Screen_WiFi.bat connect ip_address
View_Screen_WiFi.bat disconnect ip_address
```


# Included
* ADB 
  * Android Debug Bridge version 1.0.41
  * Version 30.0.5-6877874
* scrcopy
  * Version 1.17
