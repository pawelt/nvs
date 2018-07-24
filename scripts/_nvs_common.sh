#!/usr/bin/env bash

export NVS_VER=1.0.0

export NVS_V_DIR=$NVS_DIR/v

export NVS_DEFAULT_VER_CFG="$NVS_DIR/nvs-default-ver.txt"
if [ -s $NVS_DEFAULT_VER_CFG ]; then
    export NVS_DEFAULT_VER=`cat $NVS_DEFAULT_VER_CFG`
fi

export NVS_NODE_BIN="/bin"
if [ -d "/c/Windows" ]; then
    export NVS_NODE_BIN=""
fi

_nvs_log() {
    echo "[NVS] $1"
}
