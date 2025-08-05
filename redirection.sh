#!/bin/bash

ACTION=$1

case $ACTION in
    start)
        echo -e "\e[32m Payments services started \e[0m"
        ;;
    stop)
        echo -e "\e[34m Payment services stopped \e[0m"
        ;;
    restart)
        echo -e "\e[35m Payments services resarted \e[0m"
        ;;
    *)
        echo "Valid options are start or stop or restart"
        echo -e "Ex \n\t scriptname.sh stop"
        ;;
esac