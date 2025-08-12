#!/bin/bash

case $UID in
    0)
        echo "you are root user"
        ;;
    100)
        echo "You are ubuntu user"
        ;;
    *)
        echo "you are normal user"
        ;;
esac