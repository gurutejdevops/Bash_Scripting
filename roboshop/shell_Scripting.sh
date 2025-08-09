#!/bin/bash
# Description: 
# Author:
# Date Created:
# Version: 
# Date Modified:
case $1 in
    1)
        echo "welcome Linux sesions";;
    2)
        sudo yum update;;
    3)
        sudo yum install nginx -y;;
    *)
        echo "Please enter a correct value"
		echo "./script12.sh 1/2/3/4 (1: greet | 2: update apt |3: install java | 4: install tree)";;
esac
