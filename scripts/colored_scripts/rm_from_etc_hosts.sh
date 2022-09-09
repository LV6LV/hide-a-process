#!/bin/bash
: << 'COMMENT' 
This is a simple script to clean /etc/hosts

COMMENT
# Define colors...
RED=`tput bold && tput setaf 1`
GREEN=`tput bold && tput setaf 2`
YELLOW=`tput bold && tput setaf 3`
BLUE=`tput bold && tput setaf 4`
NORM=`tput sgr0`

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
# Main function
function gREP() {
    grep -v $term /etc/hosts >> /tmp/hosts; mv /tmp/hosts /etc/hosts; tac /etc/hosts 
}

if [[ $(id -u) -ne "0" ]]; then
    RED "[error] You must run this as root... try sudo?\n\n" >&2
    exit 1
fi

BLUE "Info in /etc/hosts file:\n\n"
tac /etc/hosts
printf "\n"
read -p "Provide the host you would like to remove: " term
printf "\r\n"

gREP && BLUE "An attempt was made\r\n"
