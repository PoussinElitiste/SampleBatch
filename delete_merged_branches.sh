echo "update submode"
git branch --merged| egrep -v "(^\*|master|dev|preprod|i/ftue)" | xargs git branch -d 
# git branch --list b/* | xargs git branch -D
read -rsp $'Press any key to continue...\n' -n1 key
# $SHELL