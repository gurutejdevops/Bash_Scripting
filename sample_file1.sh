#!/bin/bash

USER_ID=$(whoami)


stat()
{
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[34m failure \e[0m"
    fi
}

echo -e -n "\e[33m Installing nginx \e[0m"

yum install nginx -y &>> LOGFILE.txt

stat $?




