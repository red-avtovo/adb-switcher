#!/bin/sh

switchTimeout=10
source ${SCRIPTS_LOCATION}/switcherFunctions.sh

if ${DEBUG}; then
    echo "DEBUG is enabled"
fi

while :
do
    deviceList=$(adb devices | grep "device" | awk 'NR>1 {print $1}')
    for id in ${deviceList}; do
        if ${DEBUG}; then
            echo "found device #${id}"
        fi
        timeout ${switchTimeout} "source ${SCRIPTS_LOCATION}/switcherFunctions.sh; switch2wifi ${id}" || banDevice ${id}
    done
    if ${DEBUG}; then
        unauthorizedDevices=$(adb devices | grep "unauthorized" | wc -l)
        if [ "$unauthorizedDevices" -gt "0" ]; then
            echo "$unauthorizedDevices devices are unauthorized"
            echo ""
        fi
    fi
    sleep 5
done