#!/bin/bash

echo "If Usage"

ACTION=$1

if [ "$ACTION" == "Start" ]; then

    echo "Payment Services started"
    exit 0
else
    echo "Valid option is start"
    exit 1
fi