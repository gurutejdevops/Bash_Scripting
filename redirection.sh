#!/bin/bash

$ACTION=$1

case $ACTION IN
    start)
        echo "Payments services started"
        ;;
    stop)
        echo "Payment services stopped"
        ;;
    restart)
        echo "Payments services resarted"
        ;;
esac