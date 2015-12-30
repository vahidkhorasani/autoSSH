#!/bin/bash -x
# text colors
BlackRed="\033[31;40m"
BlackGreen="\033[32;40m"
BlackYellow="\033[33;40m"
BlackBlue="\033[34;40m"
BlackViolet="\033[35;40m"
BlackCyan="\033[36;40m"
BlackWhite="\033[37;40m"
reset="\033[0m"
file="${HOME}/destination.list"

echo -e "${BlackYellow}###Please enter the hostname / IP address to add to your list###${reset} "

read -p "Is there any host to add to your list ? [y] " answer

while [[ ${answer} = "y" ]]; do
if [[ -z ${answer} ]]; then
	answer="y"
	read -p  "Hostname/IP: " dest
elif [[ ${answer} == y ]]; then
	read -p  "Hostname/IP: " dest
elif [[ ${answer} != y ]]; then
	echo -e "your list will be saved to ${HOME}/destinations.list "
fi
done
