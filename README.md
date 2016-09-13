Welcome to SSH automation

AutoSSH
=========

Introduction 
------------- 
It's free and you can download and use it and also redistribute it.There is a manual page which is associated with the program.Please download it and then copy it to the manpath of your system to have a better understanding of it.   
You can also add this script to your PATH and have it as one of your shell commands.

I hope you enjoy it !

Version 1.0 - Sun 3 Jan 2016
by Vahid Khorasani <vh.khorasani@yahoo.com>


Version 2.0 - Mon 7 Mar 2016
by Vahid Khorasani <vh.khorasani@yahoo.com>
features added in this version:
------------------------------
- ability to edit the list using '-c' option
- ability to delete from list using '-d' option
- ability to add destinations to '/etc/host' file
- ability to connect using destination names using '-n' option


Version 3.0
By Vahid Khorasani <vh.khorasani@yahoo.com>
In this version autossh is available in Python and you can run this script using Python.(Python3.5)
All the features are available and you can use each of them that you are more comfortable with.For example you can use one of them for creating your list and the other one for editing or connecting.
Although both of them are perfect in operation but the one that has been written in Python is better in '-n' option, because it searchs and finds the hostname from the 'autossh' file that you yourself create but in the
Bash version this operation is based on your '/etc/hosts' file.So if you use Python script you can use '-n' option for all your destinations but if you use Bash script you can only use this option for the hosts that you have added to
your '/etc/hosts' file.