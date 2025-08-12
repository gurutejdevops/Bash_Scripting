#!/bin/bash

ACTION=$1

case ${ACTION} in
    start)
        echo -e "\e[31m Payment Services started \e[0m"
        ;;
    stop)
        echo -e "\e[32m Payment services stopped \e[0m"
        ;;
    *)
        echo -e "\e[32m Please select start or stop services \e[0m"
        ;;
esac