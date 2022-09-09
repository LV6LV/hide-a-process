## Just some notes

# add color to the whole line.
```
#!/bin/bash
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
RED "This text is red"
GREEN "\nThis is green"
YELLOW "\nYellow"
BLUE "\nThis is blue\n"
printf "\n"
```
