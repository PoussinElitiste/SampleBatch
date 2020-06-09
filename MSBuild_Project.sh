#!/bin/bash
echo "1. check 8dot3name(long ot short path) status"
fsutil 8dot3name query
echo "If 8dot3name is disabled (1), enable the short name feature and create short name using the command:"
echo 'enable cmd        : fsutil behavior set disable8dot3 0'
echo 'create short name : fsutil file setshortname "Program Files" PROGRA~1'
echo 'check short path  : cd /x'

if [ -z "$VCVARS64" ]
then
	echo "\$VCVARS64 set to C:\PROGRA~2\MICROS~1\2017\Professional\VC\Auxiliary\Build\vcvars64.bat"
	export VCVARS64="C:\PROGRA~2\MICROS~1\2017\Professional\VC\Auxiliary\Build\vcvars64.bat"
else
	echo $VCVARS64
fi

pushd Build
cmd '/c %VCVARS64% && msbuild /p:Configuration=Debug Arkanoid.sln -fl -flp:logfile=Arkanoid_MSBuild.log;verbosity=n'
read -rsp $'Press any key to continue...\n' -n1 key
#popd
# $SHELL