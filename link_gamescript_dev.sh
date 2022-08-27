#!/bin/bash
# calculate script folder path
# note:
# - DIR allow to define a context execution path without change current directory path  
# - 2>&1 redirects all standard error to standard output (disable error display)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

$DIR/link_gamescript.sh -t 'dev' -k

if [ $? -ne 0 ]; then
 	echo "Cannot link gamescript"
 	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
	exit 1
fi

exit 0