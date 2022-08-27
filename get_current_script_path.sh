#!/bin/bash

# get path of the current script 
SCRIPT_PATH="${BASH_SOURCE:-$0}"
echo "Value of SCRIPT_PATH: ${SCRIPT_PATH}"

read -rsp $'Press any key to continue...\n' -n1 key