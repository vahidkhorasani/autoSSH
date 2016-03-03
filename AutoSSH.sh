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
hosts="/tmp/hosts"
backup="/tmp/destination.list.backup"
touch ${file}
touch ${backup}
touch ${hosts}
######## This section is for creating a list from your most often used destinations
# This part of script is for skipping the edition of your list if it exists.
while [[ -f ${file} ]]; do
	if [[ ! -s ${file} && $# -eq 0 ]]; then
		cat <<- EOF
		You haven't any destination list to be used by 'AutoSSH'.
		To get the most of this script you need to make your own list including your most often used destinations.
		So, if you like to make it now, try "AutoSSH" with "-e" option.
		EOF
		exit 0

# This part is for '-e' flag
	elif [[ $# -eq 1 ]]; then

while getopts :e option; do
	case ${option} in
		e)

echo "Make your own list"
read -p "Continue with editing your list ? [y] " answer
read -p "Do you wanna add your destinations to your '/etc/hosts' file ? [y] " ETC

if [[ -z ${ETC} || ${ETC} = "y" || ${ETC} = "yes" ]] && [[ ${USER} != root ]]; then
	echo -e "${BlackRed}permission denied${reset}"
	exit 0
fi
while [[ -z ${answer} || ${answer} = "y" || ${answer} = "yes" ]]; do
	answer="y"

  	while [[ ${answer} = "y" ]]; do
	read -p "Enter Hostname/IP: " dest
	read -p "Pick a name for this IP address: " name
	read -p "Enter the username you wanna use to login: " user
	echo "'${name}'":${dest}:${user} >> ${file}
	echo "${dest}	${name}" >> ${hosts}
	read -p "Is there any other hosts you wanna add to your list ? [y] " answer

	  if	[[ -z ${answer} || ${answer} = "y" || ${answer} = "yes" ]]; then
	  	answer="y"
	  elif	[[ ${answer} = "n" || ${answer} = "no" ]]; then
		echo "your list has been saved to '${file}'"
		echo "you have also a backup list at '${backup}'"
		# Uncomment the following line if you wanna check the destination list with more detail.
		#echo -ne "${BlackBlue}$(cat ${file})\n${reset}"
	  else
		echo -e "${BlackRed}NO VALID INPUT${reset}"
		read -p "Is there any other hosts you wanna add to your list ? [y] " answer
	  fi

	done

done;;
		?) echo -e "${BlackRed}I don't know what '${OPTARG}' is!${reset}";;
	esac
	#exit 0
done

if [[ -z ${ETC} || ${ETC} = "y" || ${ETC} = "yes" ]]; then
	cat ${hosts} >> /etc/hosts
fi

fi
	break
done

NUM_LINE="$(sort ${file} | wc -l)"

rsync ${file} ${backup}
echo "Here are your most often used destionations: "

for (( i=1 ; i<=${NUM_LINE} ; i+=1 ))
	do
		echo -ne "${i}: $(sort ${file} | cut -d ":" -f 1 | sed -n ${i}p)\n"
	done

# Script will be started from here if you run it without '-e' option
read -p "Do you wanna connect now ? [y] " connect
	while [[ -n ${connect} || ${connect} != "y" || ${connect} != "yes" || ${connect} != "n" || ${connect} != "no" ]]; do
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
	exit 0
# Uncomment this if you want to confirm the information before connecting.
#read -p "confirm ?[y]" confirm
#if [[ -z ${confirm} || ${confirm} = "y" || ${confirm} = "yes" ]]; then
#ssh ${USERNAME}@${NODE_IP}
#else
#exit 0
#fi
	elif [[ ${connect} = "n" || ${connect} = "no" ]]; then
		exit 0
	else
		echo -e "${BlackRed}NO VALID INPUT!${reset}"
		read -p "Do you wanna connect now ? [y] " connect
fi

done
