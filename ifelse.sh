#!/bin/bash

echo "If Usage"

ACTION=$1

if [ "$ACTION" == "Start" ]; then

    echo "Payment Services started"
    exit 0

elif [ "$ACTION" == "stop" ]; then

    echo "Payment option is stop"
    exit 1

elif [ "$ACTION" == "restart" ]; then

    echo "Payment service restarted"
    exit 2
else
    echo "ALL OK"
    exit 3
fi