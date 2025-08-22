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

echo -n "Root access checking:"

if [ ${USER_ID} != root ]; then

    echo "The run the script with sudo access"
fi

stat $?



