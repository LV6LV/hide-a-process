#!/usr/bin/env bash
: << 'COMMENT' 
A simple script to hide a process
Created by @MatheuzSecurity
https://twitter.com/inferigang
Now with color!

COMMENT

# Colors Defined
RED=`tput bold && tput setaf 1`
GREEN=`tput bold && tput setaf 2`
YELLOW=`tput bold && tput setaf 3`
BLUE=`tput bold && tput setaf 4`
NORM=`tput sgr0`

# Aux Functions
function RED(){
	printf "\n${RED}${1}${NORM}"
}
function GREEN(){
	printf "\n${GREEN}${1}${NORM}"
}
function YELLOW(){
	printf "\n${YELLOW}${1}${NORM}"
}
function BLUE(){
	printf "\n${BLUE}${1}${NORM}"
}
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

# Variables
_start=1

# This accounts as the "totalState" variable for the ProgressBar function
_end=100

# Main Functions
function mkFolder() {
        rm -rf /tmp/hidden
        mkdir /tmp/hidden
        if [[ $? -ne 0 ]]; then
                RED "[error] An error has ocurred/n/n" >&2
                exit 1
        fi
}
function hideProcess() {
        cp /etc/mtab /tmp/mtab ; mount --bind /tmp/hidden /proc/$pid ; mv /tmp/mtab /etc/mtab
}
function listProcess() {
	BLUE "Simple Process List:\n\n"
        ps -efa -o ppid,pid,tty,comm
}
function currentProcinfo(){
	GREEN "\nCurrent Process Info:\n\n"
	printf "PPID=$PPID PID=$$ TTY=";tty
}

if [[ $(id -u) -ne "0" ]]; then
        RED "[error] You must run this script as root\n\n" >&2
        exit 1
fi

for number in $(seq ${_start} ${_end})
do
        sleep 0.01 # This changes the speed of the bar
        ProgressBar ${number} ${_end}
done

currentProcinfo
listProcess
printf "\r\n"
read -p "Process ID to hide: " pid

mesg="Your PID was successfully hidden!"

mkFolder && hideProcess && \

for i in $(seq 1 ${#mesg}); do
        printf "${RED}${mesg:i-1:1}${NORM}"
        sleep 0.022
done
printf "\r\n"
