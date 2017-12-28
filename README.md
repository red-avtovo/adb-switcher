to debug adb

`docker run --rm -ti --privileged adb-switcher sh`

to run switcher

`docker run -d -v ~/.android:/root/.android --name adb-switcher --privileged adb-switcher`

to run switcher with debug

`docker run --rm -ti -v ~/.android:/root/.android -e DEBUG=true --name adb-switcher --privileged adb-switcher`
