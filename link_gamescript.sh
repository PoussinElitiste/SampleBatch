#!/bin/bash -> for execute sh on linux/Mac  
echo "Link gamescript ..."
echo

# calculate script folder path
# note:
# - DIR allow to define a context execution path without change current directory path  
# - 2>&1 redirects all standard error to standard output (disable error display)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

# where to retrieve files
SOURCE_NAME="branch"
BRANCH_NAME="i/ftue"
SOURCE="$DIR/$SOURCE_NAME"

# where to create junction
TARGET_NAME="du-i-ftue"

SKIP_FILES=0
# retrieve options
while getopts "s:t:k" flag; do
  case "${flag}" in
    s) SOURCE_NAME="${OPTARG}"
   	   ;;
	t) TARGET_NAME="${OPTARG}" 
	   ;;
	k) SKIP_FILES=1
	   ;;
    *) echo "Usage: link_gamescript [-s] <SOURCE_NAME> [-t] <TARGET_NAME>"
	   read -rsp $'Press any key to continue...\n' -n1 key # pause hack
       exit 1 ;;
  esac
done

echo "SOURCE_NAME=$SOURCE_NAME"
echo "TARGET_NAME=$TARGET_NAME"

TARGET="$DIR/$TARGET_NAME"
FIND_TARGET="$(find $DIR -maxdepth 1 -type d  -name $TARGET_NAME | wc -l)"

FIND_SOURCE_NAME="$(find $SOURCE -maxdepth 1 -type d  -name $SOURCE_NAME | wc -l)"

SCRIPTS_NAME="Scripts"
DOC_NAME="doc"

GAMESCRIPT="$TARGET/data/game/gamescript"
WIN_GAMESCRIPT="$(cygpath -w "${GAMESCRIPT}")"

# create execution context
cd "$DIR"

echo "Step 1. remove folder"
rm -Rf "$TARGET/data/game/gamescript" >/dev/null 2>&1

if [ $? -ne 0 ]; then
	echo $?
 	echo "Cannot delete folder"
 	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
	exit 1
else
	echo " -> Folder removed"
fi 

echo "Step 2. create link"
#ln -s ./gamescript/ ./du-i-ftue/data/game/ #Linux version
#cmd //c mklink /J "du-i-ftue\data\game\gamescript" "gamescript" #DOS version
cmd <<< 'mklink /J \"$WIN_GAMESCRIPT\" \"gamescript\"' >/dev/null 2>&1

if [ $? -ne 0 ]; then
	echo $?
 	echo "Cannot create link"
 	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
	exit 1
else
	echo " -> Link created"
fi 

if [ $SKIP_FILES -eq 0 ]; then
	echo "Step 3. check missing files"
	# TODO: we should backup script path to prevent cd "$DIR" dependency
	./gamescript/retrieve_branch.sh -s $SOURCE_NAME -b $BRANCH_NAME

	if [ $? -ne 0 ]; then
	 	echo "Cannot retrieve $SOURCE_NAME folder call 911 dev"
	 	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
		exit 1
	fi
else
	echo "Step 3. skip files check"
	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
	exit 0
fi

echo "Step 4. copy missing files"
if [ $FIND_TARGET -eq 0 ]; then
	echo "$TARGET_NAME folder not found"
	exit 1
else 
	echo " -> $TARGET_NAME folder found"
fi

cp -rf "$SOURCE/$SCRIPTS_NAME" "$TARGET/" >/dev/null 2>&1

if [ $? -ne 0 ]; then
 	echo "Cannot copy $SCRIPTS_NAME folder call 911 dev"
 	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
	exit 1
else
	echo " -> $SCRIPTS_NAME copied"
fi 

cp -rf "$SOURCE/$DOC_NAME" "$TARGET/" >/dev/null 2>&1

if [ $? -ne 0 ]; then
 	echo "Cannot copy $DOC_NAME folder call 911 dev"
 	read -rsp $'Press any key to continue...\n' -n1 key # pause hack
	exit 1
else
	echo " -> $DOC_NAME copied"
fi

#$SHELL # to keep window open
read -rsp $'Press any key to continue...\n' -n1 key # pause hack
exit 0