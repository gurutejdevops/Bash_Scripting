#!/bin/bash

echo "if usage"

ACTION=$1

if [ "${ACTION}" == "start" ] ; then

    echo "Payment services started"
else
    echo "Valid option is start only"
fi