#!/usr/bin/env bash

default_user="ubuntu"

echo -e "Creating ubuntu user"
cat /etc/passwd | grep ${default_user} > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo -e "User ubuntu exists"
else
	sudo adduser $default_user
fi

echo -e "Giving ubuntu user a sudo access"
sudo echo "$default_user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$default_user

echo -e "Creating .ssh folder to ubuntu home folder"
if [ -d "/home/$default_user/.ssh/" ] ; then
	echo -e "Directory .ssh exists"
else
	sudo mkdir /home/$default_user/.ssh/
fi

echo -e "Fix .ssh folder permission" 
sudo chown -R $default_user.$default_user /home/$default_user/.ssh/

echo -e "Copy ubuntu-default-user@vagrant.pub into .ssh"
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMKB+RS2anbnY+T5jah9EjLDLX0JVH433xr55NMOdjkZ5i7bPvY7P8KRaLiEdbzK9dWTzR3v7cwEVkxY/AwilqJSxzSF3tNKybj3JvXK3jpzaOaDMPRzmWdV1s3xStAXwgCe9Uz7G22lhv37pZKNxYncpSq+g/LqZMBDcSm/lEzi6Dh5QsrCCuCvhgxc9lq7h1fHOES5Lwdk6wECnpBXrLIkcNNMo+6ubieXHj6rfW998VjC+vwMInUvwWxlFCh6p8e3aTti7/PPfYtlmjNhUKnEPJOz5ei7ONtgXzdlnaz0FWgM6dqrlMTWYz2d/cvEdVabYYAtb6iSeoQEfDvJjh ubuntu-default-user@vagrant
" > /home/$default_user/.ssh/authorized_keys

echo -e "Fix authorized_keys permission"
sudo chown -R $default_user.$default_user /home/$default_user/.ssh/*

echo -e "Updating system"
sudo apt-get update -y

echo -e "Installing ansible on system"
sudo apt-get install ansible -y

echo -e "Installing python-apt on system"
sudo apt-get install python-apt-common python-apt python3-apt -y