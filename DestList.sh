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
NUM_LINE=$(sort ${file} | wc -l)
USERNAME=$(sort ${file} | cut -d ":" -f 3)
NODE=$(sort ${file} | cut -d ":" -f 2)


# This section is for creating a list from your most often used destinations
echo -e "${BlackGreen}Please enter the hostname / IP address to add to your list:${reset} "
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
		echo -e "your list has been saved to ${BlackGreen}'${HOME}/destinations.list'${reset}."
		echo -e "you can check it out now:"
		echo -ne "${BlackBlue}$(cat ${file})\n${reset}"
	  else
		echo -e "${BlackRed}NO VALID INPUT${reset}"
		read -p "Is there any host to add to your list ? [y] " answer
	  fi
  done

done

echo
echo -e Â"${BlackGreen}Select your destionation:${reset} "

#select destination in ${LIST}

for (( i=1 ; i<=${NUM_LINE} ; i+=1 ))
	do
		echo -ne "${i}: $(sort ${file} | cut -d ":" -f 1 | sed -n ${i}p)\n"
	done



#		case $d in
#			$(echo ${LIST} | sed -n '{i}p'))	echo  $(${USERNAME} | sed -n '${i}p')@$(${NODE} | sed -n '${i}p');;
