#!/bin/bash

ACTION=$1

case $ACTION in
    start)
        echo "Start the payment Service"
        ;;
    stop)
        echo "Stop the payment Service"
        ;;
    restart)    
        echo "Restart the payment Service"
        ;;           
esac