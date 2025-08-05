#!/bin/bash

ACTION=$1

case $ACTION in
    start)
        echo "Payments services started"
        ;;
    stop)
        echo "Payment services stopped"
        ;;
    restart)
        echo "Payments services resarted"
        ;;
    *)
        echo "Valid options are start or stop or restart"
        echo -e "Ex \n\t scriptname.sh stop"
        ;;
esac