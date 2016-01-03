Welcome to SSH automation

AutoSSH
=========
Version 1.0 - Sun 3 Jan 2015
by Vahid Khorasani
<vh.khorasani@yahoo/gmail.com>


Introduction 
================= 
This is a simple bash script for anyone (specially for SysAdmins) whose his major deal is working with servers and other devices like that. This script create a list 
from your most often used destinations by getting required information from you. After this list is been created it'll be saved on your system and this script will refer to it anytime you try to 
connect to your destination.After your create your list the only thing that is needed is JUST a number that script will ask you when ever you wanna connect.

This list is defined with hostname or IP address of destinations and ofcourse the username that you use for connecting. In this script my assumption is that you use public key authentication method 
to connect to your devices ,which is more secure than password authentication. On the other, if you wanna use username and password you must enter your credentials in the script which make the script 
so unsecure and vulnerable.

Running the script for 1st time 
=================================== 
When you run the script for the first time it will try to make a list with your help so you must run it with "-e" flag and you can 
also use this option when ever you want to add new destination to your list.So, if you have already run the script and the "destination.list" file exist on your system the script will only show you 
your list and will ask you about the destination you wanna connect JUST by entering a number.


I hope you enjoy it !
