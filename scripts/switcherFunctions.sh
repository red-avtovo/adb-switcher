#!/bin/sh

banFile="/opt/ban.log"

################################################################################
# Executes command with a timeout (requires tool: expect)
# Params:
#   $1 timeout in seconds
#   $2 command
# Returns 1 if timed out 0 otherwise
# EG: timeout 10 "ls ${HOME}"
timeout() {
    time=$1

    # start the command in a subshell to avoid problem with pipes
    # (spawn accepts one command)
    command="/bin/sh -c \"$2\""

    expect -c "set echo \"-noecho\"; set timeout $time; spawn -noecho $command; expect timeout { exit 1 } eof { exit 0 }"
}


switch2wifi() {
    id=$1
    if [ ! -f ${banFile} ]; then
        touch ${banFile}
    fi
    banned=$(cat ${banFile} | grep ${id})
    if [ -z "${banned}" ]; then
        if ${DEBUG}; then
            echo "switching device #${id}"
        fi
        adb -s ${id} tcpip 5555
    else
        if ${DEBUG}; then
            echo "device #${id} was banned"
        fi
    fi
}

banDevice() {
    id=$1
    if ${DEBUG}; then
            echo "baning device #${id}"
        fi
    if [ ! -f ${banFile} ]; then
        touch ${banFile}
    fi
    echo "${id}" >> ${banFile}
}
