#!/bin/bash
: << 'COMMENT' 
This is a simple script to clean /etc/hosts

COMMENT

function eCHO() {
    echo "$ip $term" >> /etc/hosts ; tac /etc/hosts 
}

if [[ $(id -u) -ne "0" ]]; then
    echo "[error] You must run this as root... try sudo?" >&2
    exit 1
fi

echo -ne "\r"
tac /etc/hosts
echo -ne "\r"
echo -ne "Lets add a new host"
read -p "Provide the ip first: " ip
read -p "Provide name.htb to use: " term
echo -ne "\r"

eCHO && echo -ne "\n An attempt was made. \n"
