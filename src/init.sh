#!/bin/bash

# SIGINT handler
trap 'echo -e "\nStopping Doxygen ..."; exit 0' SIGINT

eval apache2ctl start

# Keep alive
while true; do
    sleep 3
done

exit 0
