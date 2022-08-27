#!/bin/bash

# calculate script folder path
# note:
# - DIR allow to define a context execution path without change current directory path  
# - 2>&1 redirects all standard error to standard output (disable error display)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

SOURCE_NAME="branch"
BRANCH_NAME="i/ftue"

# retrieve options
while getopts 's:b:' flag; do
  case "${flag}" in
    s) SOURCE_NAME="${OPTARG}" ;;
	b) BRANCH_NAME="${OPTARG}" ;;
    *) echo "Usage: retrieve_branch [-s] <SOURCE_NAME> [-b] <BRANCH_NAME>"
	   read -rsp $'Press any key to continue...\n' -n1 key # pause hack
       exit 1 ;;
  esac
done

SOURCE="$DIR/$SOURCE_NAME"
FIND_SOURCE="$(find $DIR -maxdepth 1 -type d  -name $SOURCE_NAME | wc -l)"

SCRIPTS_NAME="Scripts"
DOC_NAME="doc"
REF_FOLDER_NAME="data/gui/common/codex/css"
#FIND_SCRIPTS="$(find $SOURCE -maxdepth 1 -type d  -name $SCRIPTS_NAME | wc -l)"

# create execution context
cd "$DIR"

if [ $FIND_SOURCE -eq 0 ]; then
	echo "create folder"
	mkdir $SOURCE_NAME
else 
	echo "$SOURCE_NAME folder found"
fi

pushd $SOURCE >/dev/null 2>&1
	echo "check git"
	git status >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo "init git"
		git init
	else 
		echo "git folder found"
	fi 

	echo "check repo" 
	git log >/dev/null 2>&1

	if [ $? -ne 0 ]; then
		echo "setup path"
		git remote add -f origin ssh://git@git.novaquark.com/dual/dual-client.git

		echo "config sparse" 
		git config core.sparseCheckout true
		echo "$SCRIPTS_NAME/*" >> .git/info/sparse-checkout
		echo "$DOC_NAME/*" >> .git/info/sparse-checkout
		echo "$REF_FOLDER_NAME/*" >> .git/info/sparse-checkout
	else
		echo "repo initialized"
	fi

	echo "reset $SOURCE_NAME"
	git reset --hard origin/$BRANCH_NAME

	# echo "check $SCRIPTS_NAME"
	# if [ $FIND_SCRIPTS -eq 0 ]; then
		
		#git pull origin master
		# check that no files are missing
	 	#git reset --hard origin master
	# else
		# echo "$SCRIPTS_NAME found"
	# fi
popd >/dev/null 2>&1

#$SHELL # to keep window open
#read -rsp $'Press any key to continue...\n' -n1 key # pause hack
exit 0