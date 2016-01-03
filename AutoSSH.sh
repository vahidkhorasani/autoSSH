#!/bin/bash

# These are for changing the format of texts
BlackRed="\033[31;40m"
BlackGreen="\033[32;40m"
BlackYellow="\033[33;40m"
BlackBlue="\033[34;40m"
BlackViolet="\033[35;40m"
BlackCyan="\033[36;40m"
reset="\033[0m"

# This is the destination to where the result will be saved
file="${HOME}/destination.list"
touch ${file}

# This section is for creating a list from your most often used destinations
echo -e "${BlackGreen}Make your own list${reset} "
read -p "Is there any host you wanna add to your list ? [y] " answer

while [[ -z ${answer} || ${answer} = "y" || ${answer} = "yes" ]]; do
	answer="y"

  	while [[ ${answer} = "y" ]]; do
	read -p  "Hostname/IP: " dest
	read -p "Enter a name to associate your destination: " name
	read -p "Enter the username you use to login: " user
	echo "'${name}'":${dest}:${user} >> ${file}
	read -p "Is there any host to add to your list ? [y] " answer

	  if	[[ -z ${answer} || ${answer} = "y" || ${answer} = "yes" ]]; then
	  	answer="y"
	  elif	[[ ${answer} = "n" || ${answer} = "no" ]]; then
		echo -e "your list has been saved to ${BlackGreen}'${HOME}/destinations.list'${reset}"
		echo -ne "${BlackBlue}$(cat ${file})\n${reset}"
	  else
		echo -e "${BlackRed}NO VALID INPUT${reset}"
		read -p "Is there any host to add to your list ? [y] " answer
	  fi


	done

done

NUM_LINE="$(sort ${file} | wc -l)"

echo
echo -e Â"${BlackGreen}Here are your most often used destionations:${reset} "

for (( i=1 ; i<=${NUM_LINE} ; i+=1 ))
	do
		echo -ne "${i}: $(sort ${file} | cut -d ":" -f 1 | sed -n ${i}p)\n"
	done

read -p "Enter your number to connect: " number

USERNAME="$(sort ${file} | sed -n ${number}p | cut -d ":" -f 3)"
NODE_IP="$(sort ${file} | sed -n ${number}p | cut -d ":" -f 2)"
NODE_NAME="$(sort ${file} | sed -n ${number}p | cut -d ":" -f 1)"

echo -e "${BlackViolet}DEST:${NODE_NAME}${reset}"
echo -e "${BlackViolet}IP/HOSTNAME:${NODE_IP}${reset}"
echo -e "${BlackViolet}Username:${USERNAME}${reset}"

read -p "Do you confirm ?[y]" confirm

if [[ -z ${confirm} || ${confirm} = "y" || ${confirm} = "yes" ]]; then
	ssh ${USERNAME}@${NODE_IP}
else
	exit 0
fi
