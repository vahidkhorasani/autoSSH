#!/bin/bash

# These are for changing the format of texts
BlackRed="\033[31m"
BlackGreen="\033[32m"
BlackBlue="\033[34m"
BlackViolet="\033[35m"
BlackCyan="\033[36m"
reset="\033[0m"

# This is the destination to where the result will be saved
file="${HOME}/destination.list"
touch ${file}

######## This section is for creating a list from your most often used destinations

# This part of script is for skipping the edition of your list if it exists.
while [[ -f ${file} ]]; do

	if [[ ! -s ${file} && $# -eq 0 ]]; then

		cat <<- EOF
		This is the first time you are running this script.
		To get the most of it you need to make your own list including your most often used destinations.
		So, if you like to make it now, try "AutoSSH" with "-e" option.
		Hope you enjoy it !
		EOF

		exit 0
	elif [[ $# -eq 1 ]]; then

# This part is for edit flag
while getopts :e option; do
	case ${option} in
		e)

echo -e "${BlackGreen}Make your own list${reset} "
read -p "Are you sure you wanna edit your list ? [y] " answer

while [[ -z ${answer} || ${answer} = "y" || ${answer} = "yes" ]]; do
	answer="y"

  	while [[ ${answer} = "y" ]]; do
	read -p  "Enter Hostname/IP: " dest
	read -p "Pick a name fo this IP address: " name
	read -p "Enter the username you wanna use to login: " user
	echo "'${name}'":${dest}:${user} >> ${file}
	read -p "Is there any other hosts you wanna add to your list ? [y] " answer

	  if	[[ -z ${answer} || ${answer} = "y" || ${answer} = "yes" ]]; then
	  	answer="y"
	  elif	[[ ${answer} = "n" || ${answer} = "no" ]]; then
		echo -e "your list has been saved to ${BlackGreen}'${HOME}/destinations.list'${reset}"

# Uncomment the following line if you wanna check the whole list.
		#echo -ne "${BlackBlue}$(cat ${file})\n${reset}"
	  else
		echo -e "${BlackRed}NO VALID INPUT${reset}"
		read -p "Is there any other hosts you wanna add to your list ? [y] " answer
	  fi


	done

done;;
		?) echo -e "${BlackRed}I don't know what ${OPTARG} is!";;
	esac
done

fi
		break
done


NUM_LINE="$(sort ${file} | wc -l)"

echo
echo -e "${BlackGreen}Here are your most often used destionations:${reset} "

for (( i=1 ; i<=${NUM_LINE} ; i+=1 ))
	do
		echo -ne "${i}: $(sort ${file} | cut -d ":" -f 1 | sed -n ${i}p)\n"
	done

read -p "Do you wanna connect now ? [y] " connect
	if [[ -z ${connect} || ${connect} = "y" || ${connect} = "yes" ]]; then

read -p "Enter a number to connect: " number

while [[ ${number} -gt ${NUM_LINE} ]]; do
	if [[ ${number} -gt ${NUM_LINE} ]]; then
		echo -e "${BlackRed}your number is not in the valid range.${reset}"
		read -p "your number is: " number
	else
		exit 0
	fi
done

USERNAME="$(sort ${file} | sed -n ${number}p | cut -d ":" -f 3)"
NODE_IP="$(sort ${file} | sed -n ${number}p | cut -d ":" -f 2)"
NODE_NAME="$(sort ${file} | sed -n ${number}p | cut -d ":" -f 1)"

echo -e "${BlackGreen}Username:${USERNAME}${reset}"
echo -e "${BlackGreen}IP/HOSTNAME:${NODE_IP}${reset}"
echo -e "${BlackGreen}NAME:${NODE_NAME}${reset}"

	ssh ${USERNAME}@${NODE_IP}

# Uncomment this if you want to confirm the information before connecting.
#read -p "confirm ?[y]" confirm
#if [[ -z ${confirm} || ${confirm} = "y" || ${confirm} = "yes" ]]; then
#ssh ${USERNAME}@${NODE_IP}
#else
#exit 0
#fi

fi
