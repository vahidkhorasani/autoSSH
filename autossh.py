#!/usr/bin/python3.5
import getpass
import os
import sys
import fileinput
import subprocess
from colorama import Fore,Back,Style

DIR = os.environ['HOME'].__add__('/.jafar')
FILE = DIR.__add__('/autossh')
BACKUP = '/tmp/autossh.backup'
HOSTS = '/etc/hosts'

def main():

	make_dir()

	autossh = AutosshFile(FILE)

	while os.path.isfile(FILE) is True:
		if os.stat(FILE).st_size == 0 and len(sys.argv) == 1:
			help()
			break

		elif os.stat(FILE).st_size > 0 and len(sys.argv) == 1:
			print('Here are your most often used destionations:')
			autossh.SplitHosts(FILE)	
			CONT = input("Do you want to connect now ?[y] ")
			if CONT in ('n' , 'no'):
				break
			elif CONT in ('' , 'y' , 'yes'):
				NUM = input('Enter a number to connect: ')
				if int(NUM) > autossh.NumOfLine(FILE):
					print(Fore.RED + 'Your number is not in the valid range',Style.RESET_ALL)
				else:
					USERNAME=autossh.Username(FILE,NUM)
					IPADDR=autossh.NodeIP(FILE,NUM)
					subprocess.run(["ssh","-l",str(USERNAME),str(IPADDR)])
					break
			else:
				print(Fore.RED + "invalid input",Style.RESET_ALL)

		elif len(sys.argv) > 1 and sys.argv[1] == '-h':
			help()
			break

		elif len(sys.argv) > 1 and sys.argv[1] == '-c':
			ANSWER = input('Continue with editing your list ? [y]: ')
			if ANSWER in ('' , 'y' , 'yes'):
				ETC = input("Do you want to add destination to your '/etc/hosts' file too ? [y] ")
				if ETC in ('' , 'y' , 'yes') and getpass.getuser() != 'root' :
					print(Fore.RED + 'Permission denied' , Style.RESET_ALL)
					break
				elif ETC in ('' , 'y' , 'yes') and getpass.getuser() == 'root' :
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
						with open(HOSTS , 'a')	as hosts:
							hosts.write(DEST)
							hosts.write("	")
							hosts.write(NAME)
							hosts.write('\n')

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
					print(Fore.RED + 'No valid input', Style.RESET_ALL)
					break

			elif len(ANSWER) > 0 and ANSWER in ('n' , 'no'):
				print("Your list has been saved to" , FILE)
				print("You have also a backup list at" , BACKUP)
				sys.exit()

			else:
				print('No valid input')
				break

		elif len(sys.argv) > 1 and sys.argv[1] == '-d':
			autossh.SplitHosts(FILE)
			if os.stat(FILE).st_size > 0:
				DEL = input("Enter a number to delete: ")
				autossh.Del(FILE,int(DEL))
				print("Now your list is as follow:")
				autossh.SplitHosts(FILE)
				break
			else:
				print(Fore.RED + "Nothing to delete")
				break
		elif len(sys.argv) > 1 and sys.argv[1] == '-n':
			HOST=autossh.NodeName(FILE,sys.argv[2])
			USERNAME=autossh.HostBaseUserName(FILE,sys.argv[2])
			subprocess.run(["ssh","-l",USERNAME,HOST])
			break

class AutosshFile(object):
	
	def __init__(self,f):
		self.f = f
	
	def NodeIP(self,file_name,line_num):
		with fileinput.input(files = (file_name)) as f:
			for i,line in enumerate(f):
				if i+1 == int(line_num):
					return(line.split(":")[0])

	def NodeName(self,file_name,host_name):
		with fileinput.input(files = (file_name)) as f:
			for line in f:
				if line.split(":")[1] == host_name:
					return(line.split(":")[1])

	def HostBaseUserName(self,file_name,host_name):
		with fileinput.input(file_name) as f:
			for line in f:		
				if line.split(":")[1] == host_name:
					return(line.strip().split(":")[2].split(":")[0])

	def Username(self,file_name,line_num):
		with fileinput.input(files = (file_name)) as f:
			for i,line in enumerate(f):
				if i+1 == int(line_num):
					return(line.strip().split(":")[2].split(":")[0])

	def NumOfLine(self,file_name):
		with fileinput.input(files = (file_name)) as f:
			for line in f:
				num_lines = sum(1 for line in  open(file_name))
				return(num_lines)
		
	def SplitHosts(self,file_name):
		with fileinput.input(files = (file_name)) as f:
			for line in f:
				print(f.lineno() , ":" , line.split(":")[1])

	def Del(self,file_name,line_num):
		with open(file_name , 'r+') as f:
			l = f.readlines()
			l.__delitem__(line_num - 1)
			with open(file_name , 'w'): 
				pass
			with open(file_name , 'r+'):
				for line in l:
					f.write(line)

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
