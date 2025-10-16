# ADBToolsForWindows
Portable version of ADB and .bat files for everyday development/debugging of Android devices (based on Genymobile binaries)


# Features
* access Android device as USB drive
* enable screen copy/mirroring through USB
* enable screen copy/mirroring through WiFi 
* install APK application though USB 

# Requirements
* The device should have USB Debugging enabled
  * For Android phones: [enable the **Developer Options**](https://developer.android.com/studio/debug/dev-options), then [enable USB debugging](https://developer.android.com/studio/debug/dev-options#Enable-debugging)
  * For VR headset like Meta Quest:
    * You need a developer account and used this account to register the device.
    * Using the Meta Horizon mobile app, enable Developer Mode
    * On the device, enable USB Debugging
    * Detailed walkthrough [here](https://developers.meta.com/horizon/documentation/native/android/mobile-device-setup/)
* Don't forget to authorize your computer to access the device. You will see a popup the 1st time you connect the device to your computer.

# FAQ


## How to install an APK using command line or drag&drop ?
2 solutions:
- If the screen copy window is already open, you can drag drop your APK file directly to this window
- Alternatively you can drag drop the APK onto the **"Install Application.bat"** file



## How to mirror / screen copy my Android device on Windows ?
Android device like phone (Samsung, HTC, Xiaomi, Huawei, ...), Smartglasses (Vuzix, Realwear...) or Oculus Quest can be mirrored on Microsoft Windows
Mirroring can be done using USB connection or WiFi connection if computer and device are on the same network.

If the device is connected to any USB port of your computer, just double-click on **"View_Screen.bat"**
Using View_Screen.bat without any parameter will prompt for missing parameters like the connection to be used (USB or WiFi) and the device type (phone, quest).
You can type "**View_Screen.bat /?**" in the command line to get more options:

```
View_Screen.bat [action,connection] [device_type] [device_id,ip_address]

[action]
  (nothing)   execute all the commands step by step with interactive prompts
  devices     Show list of connected devices
  network     Retrieve network info for a USB device and enable Wifi connection
  view_usb    Start mirroring a connected device in USB
  view_wifi   Start mirroring a connected device in WiFi (network must have been done previously)
  disconnect  Interrupt network connection

[connection]
  usb         force all commands to use USB mode
  wifi        force all commands to use WiFi mode

[device_type] adjust the mirroring CROP (resolution and offset)
  phone       full mirroring
  quest1      mirror only one eye with Quest 1 resolution
  quest2      mirror only one eye with Quest 2 resolution

[device_id]   Specify the device ID if you know it
  (nothing)   Devices IDs will be displayed and prompt if more than one device is connected
```

### Command line examples
```
View_Screen.bat (interactive mode)
View_Screen.bat usb [phone,quest1,quest2] [device_id]
View_Screen.bat wifi [phone,quest1,quest2] [device_id]
View_Screen.bat devices
View_Screen.bat network [device_id]
View_Screen.bat view_usb [phone,quest1,quest2] [device_id,ip_address]
View_Screen.bat view_wifi [phone,quest1,quest2] [device_id,ip_address]
View_Screen.bat disconnect ip_address
```
To enable a WiFi mirroring from a phone already connected in USB with ID 988919474e34594255
```
View_Screen.bat wifi phone 988919474e34594255
```
                
There others Batch files which are just shortcuts to View_Screen.bat with specific parameters in case you prefer to double-click instead of the typing in the command line.


| Batch file | --> | Command line equivalent |
|---|:-:||---|
| View_Screen_USB_Phone.bat  | | ViewScreen.bat usb phone     |
| View_Screen_USB_Quest1.bat | | ViewScreen.bat usb quest1    |
| View_Screen_USB_Quest2.bat | | ViewScreen.bat usb quest2    |
| View_Screen_WiFi.bat       | | ViewScreen.bat wifi          |
| View_Screen_WiFi_Phone.bat | | ViewScreen.bat wifi phone    |
| View_Screen_WiFi_Quest1.bat| | ViewScreen.bat wifi quest1   |
| View_Screen_WiFi_Quest2.bat| | ViewScreen.bat wifi quest2   |



## Detailed behaviour on mirroring / screen copy my Android device using Wireless on Windows ?
You can stream / mirror you  Android device to any Windows on the same WiFi network.
- First, plug your device to a USB port of your computer
- **Double-click** on **"View_Screen_WiFi.bat"** or **"View_Screen.bat wifi"**
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
C:\ADBToolsForWindows>View_Screen.bat wifi

List of devices attached
988919474e34594249      device
192.168.1.50:5555       device

Enter Device ID:988919474e34594249
restarting in TCP mode port: 5555

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



# Included
* ADB 
  * Android Debug Bridge version 1.0.41
  * Version 36.0.0-13206524
* scrcopy [Genymobile scrcpy](https://github.com/Genymobile/scrcpy)
  * Version 3.3.3 
