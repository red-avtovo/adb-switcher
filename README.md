## ADB USB to Tcp/IP Switcher

Project allows to automatically switch all connected devices via USB to TCP/IP mode. 
Running this container solves the problem, when connected device was rebooted and lost tcp/ip debug config (usb is default) 

### Running
to debug adb

`docker run --rm -ti --privileged redavtovo/adb-switcher sh`

to run switcher with debug messages

`docker run --rm -ti -v ~/.android:/root/.android -e DEBUG=true --name adb-switcher --privileged redavtovo/adb-switcher`

to run switcher for prod

`docker run -d --restart=always -v ~/.android:/root/.android --name adb-switcher --privileged redavtovo/adb-switcher`

### Shared Android key
It is expected, that android devices were authorized by the host machine or switcher once. 
For persistence, android key was shared with container:

`-v ~/.android:/root/.android`

### Autostart
To start switcher after host machine reboot, provide this argument:

`--restart=always`