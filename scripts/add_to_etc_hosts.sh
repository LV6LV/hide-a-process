#!/bin/bash
: << 'COMMENT' 
This is a simple script to clean /etc/hosts

COMMENT

function eCHO() {
    printf "$ip $term \r\n" >> /etc/hosts ; tac /etc/hosts 
}

if [[ $(id -u) -ne "0" ]]; then
    printf "[error] You must run this as root... try sudo?\n\n" >&2
    exit 1
fi

printf "Info in /etc/hosts file:\n\n"
tac /etc/hosts
printf "\n"
read -p "Provide the ip first: " ip
read -p "Provide name.htb to use: " term
printf "\r\n"

eCHO && printf "\n ---- An attempt was made ---- \n"
