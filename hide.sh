#!/usr/bin/env bash
# A simple script to hide a process
# Created by @MatheuzSecurity
# https://twitter.com/inferigang

function mkFolder() {
        rm -rf /tmp/hidden
        mkdir /tmp/hidden
        if [[ $? -ne 0 ]]; then
                echo "[err] An error has ocurred" >&2
                exit 1
        fi
}

function hideProcess() {
        mount --bind /tmp/hidden /proc/$pid
}

function listProcess() {
        ps -ef -o ppid,pid,tty,comm | grep ${process}
}

if [[ $(id -u) -ne "0" ]]; then
        echo "[error] You must run this script as root" >&2
        exit 1
fi

arr=('|' '/' '-' '\')

for c in $(seq 1 5); do
        for elt in ${arr[*]}; do
                echo -ne "\r\033[<1>AInitializing $elt" && sleep 0.1;
        done
done

echo -ne "\r"
echo -ne "Lets get a list of processes. \r"
read -p "Provide one of the following values (ppid,pid,tty,comm): " process
echo -ne "\r"
read -p "Provide Process ID to hide: " pid

mesg="Your PID was successfully hidden!"

mkFolder && listProcess && hideProcess && \
#mkFolder && hideProcess && \

for i in $(seq 1 ${#mesg}); do
        echo -ne "${mesg:i-1:1}"
        sleep 0.07
done
echo -ne "\n"
