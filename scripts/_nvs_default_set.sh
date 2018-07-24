#!/usr/bin/env bash

source $NVS_DIR/scripts/_nvs_common.sh

echo $(node -v | grep -oE '[0-9].+') > $NVS_DEFAULT_VER_CFG
_nvs_log "Default version set to $(node -v)"
