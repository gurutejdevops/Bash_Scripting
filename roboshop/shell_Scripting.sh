#!/bin/bash
# Description: 
# Author:
# Date Created:
# Version: 
# Date Modified:

A="${id -u}"

case $A in
    0)
        echo "ur  root user"
        ;;
    1000)
        echo "ur centos user"
        ;;
    *)
        echo "normal user"
        ;;
esac