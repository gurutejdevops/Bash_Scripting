#!/bin/bash

stat() {
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[33m Failure \e[0m"
    fi
}   

user_id="$(whoami)"

if [ ${user_id} != root ]; then 
    echo  -e "\e[32m script expected to executef by root user or sudo access \e[0m"
else 
    echo -e "\e[34m proceed with the execution \e[0m"
fi

stat $?

echo -e "\e[32m Configuring the nginx \e[0m"
echo -e -n "\e[35m UNInstalling the nginx \e[0m"
yum remove nginx -y &>> output.log
stat $?

