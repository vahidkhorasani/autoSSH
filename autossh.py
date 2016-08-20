#!/usr/bin/python3.5
import getpass
import os
import sys
import fileinput

DIR = os.environ['HOME'].__add__('/jafar')
FILE = DIR.__add__('/autossh')
BACKUP = '/tmp/autossh.backup'

def main():

	make_dir()

	while os.path.isfile(FILE) is True:
		if os.stat(FILE).st_size == 0 and len(sys.argv) == 1:
			help()
			break
		elif os.stat(FILE).st_size > 0 and len(sys.argv) == 1:
			print('Here are your most often used destionations:')
			split_hosts(FILE)	
			NUM = input('Enter a number to connect: ')
			
		elif len(sys.argv) > 1 and sys.argv[1] == '-h':
			help()
			break
		elif len(sys.argv) > 1 and sys.argv[1] == '-c':
			ANSWER = input('Continue with editing your list ? [y]: ')
			if len(ANSWER) == 0 or ANSWER in ('y' , 'yes'):
				ETC = input("Do you want to add destination to your '/etc/hosts' file too ? [y] ")
				if (len(ETC) == 0 or ETC in ('y' , 'yes')) and getpass.getuser() != 'root' :
					print('Permission denied')
					break
				elif (len(ETC) > 0 and ETC in ('n' , 'no')) : 
					DEST = input('Enter Hostname/IP: ')	
					NAME = input('Pick a name for this destination: ')
					USER = input('Enter the username you wanna use to login: ')
					with open(FILE, 'a') as autossh:
						autossh.write(DEST)
						autossh.write(':')
						autossh.write(NAME)
						autossh.write(':')
						autossh.write(USER)
						autossh.write('\n')
				else:
					print('No valid input')
					break
			elif len(ANSWER) > 0 and ANSWER in ('n' , 'no'):
				print("Your list has been saved to" , FILE)
				print("You have also a backup list at" , BACKUP)
				sys.exit()
			else:
				print('No valid input')
				break
		#elif len(sys.argv) > 1 and sys.argv[1] == '-n':
		#
		#elif len(sys.argv) > 1 and sys.argv[1] == '-d':


def split_hosts(file_name):
	with fileinput.input(files = (file_name)) as f:
		for line in f:
			print(f.lineno() , ":" , line.split(":")[1])

def make_dir():
	if not os.path.isdir(DIR):
		os.mkdir( DIR , mode = 0o775 )
	open( FILE , 'a')

def help():

	help = """ usage: autossh [-hedn] [remote_hosname]
            Creates a list from your most often used destinations and
            will refer to it anytime you try to connet through SSH.

          Options:
            -h  show this help and exit
            -c  create/edit the dest list
            -d  delete from list
            -n  using autossh with destination name instead of selecting it from list """
	
	print(help)

if __name__ == "__main__": main()
