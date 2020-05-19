#!/bin/bash
pushd Build
cmd '/c %VCVARS64% && msbuild /t:game\Dual /p:Configuration=RelWithDebInfo Dual-client.sln -fl -flp:logfile=Dual-client_MSBuild.log;verbosity=n'
#popd