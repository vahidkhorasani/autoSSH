#!/bin/bash

# These are for changing the color of texts
BlackRed="\033[31;40m"
BlackGreen="\033[32;40m"
BlackYellow="\033[33;40m"
BlackBlue="\033[34;40m"
BlackViolet="\033[35;40m"
BlackCyan="\033[36;40m"
BlackWhite="\033[37;40m"
reset="\033[0m"

# This is the destination to where the result will be saved
file="${HOME}/destination.list"

echo -e "${BlackGreen}Please enter the hostname / IP address to add to your list:${reset} "
read -p "Is there any host you wanna add to your list ? [y] " answer

while [[ -z ${answer} ]]; do
	answer="y"

	while [[ ${answer} = "y" ]]; do
	read -p  "Hostname/IP: " dest
	echo ${dest} >> ${file}
	read -p "Is there any host to add to your list ? [y] " answer
	done
done

if [[ ${answer} != "y" ]]; then

	echo -e "${BlackGreen}your list has been saved to${reset} ${BlackBlue}'${HOME}/destinations.list'${reset}"
fi
