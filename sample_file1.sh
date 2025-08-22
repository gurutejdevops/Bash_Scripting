#!/bin/bash

USER_ID=$(whoami)

if [ ${USER_ID} != root ]; then
    echo "The run the script with sudo access"
fi

echo "SCRIPT RAN BY ROOT USER AND SUDO ACCEESS"


