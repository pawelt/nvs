#!/usr/bin/env bash

source $NVS_DIR/scripts/_nvs_common.sh

if [ "$(echo $1 | grep -E '.+\..+\..+')" = "" ]; then
    v=$(source scripts/_nvs_remote_ls_one.sh $1)
else
    v=$1
fi

if [ "$v" = "" ]; then
    _nvs_log "Could not resolve version '$1'"
    exit
fi

if [ -d $NVS_V_DIR/$v ]; then
    _nvs_log "Node version '$v' is already installed. Reinstall? [yN]"
    read reinst
    [ "$reinst" != "y" ] && [ "$reinst" != "Y" ] && exit
else
    _nvs_log "Resolved version $v"
fi

if [ "$(uname -m | grep 686)" != "" ]; then
    a=x86
else
    a=x64
fi

case $(uname) in
    Darwin)
        p=darwin
        e=tar.gz
        unpack="tar -xf"
        ;;
    Linux)
        p=linux
        e=tar.gz
        unpack="tar -xf"
        ;;
    *)
        p=win
        e=zip
        unpack="unzip -q"
        ;;
esac

tempdir=node-v$v-$p-$a
file=$tempdir.$e
link=https://nodejs.org/dist/v$v/$file

_nvs_log "Downloading $link..."
curl_status=$(curl -w '%{http_code}' -O $link)

if [ ! $curl_status = "200" ]; then
    _nvs_log "Download failed, curl status: $curl_status"
    exit
fi

_nvs_log "Exctracting to $tempdir..."
eval $unpack $file

if [ -d $v ]; then
    _nvs_log "Deleting old $v..."
    rm -rf $NVS_V_DIR/$v
fi

_nvs_log "Moving to $v..."
mv $tempdir $NVS_V_DIR/$v
rm $file

