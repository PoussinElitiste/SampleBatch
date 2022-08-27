#!/bin/bash
# calculate script folder path
# note:
# - DIR allow to define a context execution path without change current directory path  
# - 2>&1 redirects all standard error to standard output (disable error display)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

TARGET_NAME="du-i-ftue"

# retrieve options
while getopts 't:v' flag; do
  case "${flag}" in
    t) TARGET_NAME="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

echo "Update $TARGET_NAME ..."
echo

TARGET="$DIR/$TARGET_NAME"
FIND_TARGET="$(find $DIR -maxdepth 1 -type d  -name $TARGET_NAME | wc -l)"

echo "Step 1. remove folder"
rm -Rf "$TARGET/data/game/gamescript" >/dev/null 2>&1

if [ $? -ne 0 ]; then
 	echo "Cannot delete folder"
 	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
	exit 1
else
	echo " -> Folder removed"
fi 

echo "Step 2. update svn"
pushd $TARGET >/dev/null 2>&1
	echo
	echo "Cleanup client ..."
	svn cleanup #>/dev/null 2>&1
	
	if [ $? -ne 0 ]; then
	 	echo "Cannot cleanup changes"
	 	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
		exit 1
	else
		echo " -> repo clean"
	fi 

	svn revert . -R #>/dev/null 2>&1
	if [ $? -ne 0 ]; then
	 	echo "Cannot revert changes"
	 	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
		exit 1
	else
		echo " -> changes reverted"
	fi 

	echo
	echo "Update client ..."
	svn update --force --accept theirs-full #>/dev/null 2>&1
	echo
	if [ $? -ne 0 ]; then
	 	echo "Cannot update client"
	 	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
		exit 1
	else
		echo " -> client updated"
	fi 

	echo
	echo "Update assets ..."
	python ../../gism/gism.py

	if [ $? -ne 0 ]; then
	 	echo "Cannot update asset"
	 	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
		exit 1
	else
		echo " -> asset updated"
	fi 

popd >/dev/null 2>&1

# link folder
echo
./link_gamescript.sh -t $TARGET_NAME

#$SHELL # to keep window open
#read -rsp $'Press any key to continue...\n' -n1 key # pause hack