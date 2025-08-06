#!/bin/bash

#Validate the user

USER_ID="$(id -u)"

if [ ${USER_ID} -ne 0 ] ; then

    echo -e "\e[31m script is expected to execute by the root user or with a sudo privilege \e[0m \n \t Example: \n\t sudo wrapper.sh frontend.sh"
    exit 1
fi

echo "I am Fronend"

yum install nginx -y