#!/bin/bash

ACTION=$1

if [ "${ACTION}" == "start" ]; then

    echo -e "\e[31m Payment Services started \e[0m"

elif [ "${ACTION}" == "stop" ]; then

    echo -e "\e[31m Payment Services stopped \e[0m"

else

    echo -e "\e[32m Please select start or stop services \e[0m"

fi