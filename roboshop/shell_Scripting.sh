#!/bin/bash
# Description: 
# Author:
# Date Created:
# Version: 
# Date Modified:
echo "Hello there, Welcome to \"Deloitte Consulting Inc\" "
read -p "enter name:" name
read -p "enter username:" usrname
read -p "enter desg:" desg
read -p "enter shelltype:" shelltype

sudo useradd -s $shelltype -c $desg -m -d /home/$usrname $name

if [ $? -eq 0 ]; then
    echo "User created successfully"
else
    echo "Check with Admin"
fi
