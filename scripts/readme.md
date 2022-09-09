## Just some notes
# can add colors this way.
```
blue=$(tput setaf 4)
normal=$(tput sgr0)

printf "%40s\n" "${blue}This text is blue${normal}and this is normal"

```
# or add color to the whole line.
```
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
```
