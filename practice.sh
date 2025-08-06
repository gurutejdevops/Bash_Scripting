#!/bin/bash

echo "if usage"

ACTION=$1

if [ "${ACTION}" == "start" ]; then

    echo "Payment services started"
    exit 0

elif [ "${ACTION}" == "stop" ]; then

    echo "Payment services stopped"
    exit 1

elif [ "${ACTION}" == "restart" ]; then

    echo "Payment services re-started"
    exit 2

else 

    echo "Select Valid option start, stop or restart"
    exit 3
fi