#!/bin/bash

echo "If Usage"

ACTION=$1

if [ $ACTION == Start ]; then

    echo "Payment Services started"
    exit 0
fi