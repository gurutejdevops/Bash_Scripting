#!/bin/bash
# Description: 
# Author:
# Date Created:
# Version: 
# Date Modified:
case $UID in
    0)
        echo "ur  root user"
        ;;
    1000)
        echo "ur ubuntu user"
        ;;
    *)
        echo "new user"
        ;;
esac