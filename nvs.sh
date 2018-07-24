#!/usr/bin/env bash

source $NVS_DIR/scripts/_nvs_common.sh
[ ! -d $NVS_V_DIR ] && mkdir $NVS_V_DIR

# ==============================================================================
# bash-specific nvs use command
# ==============================================================================
nvs-use() {
    v=$1
    [ "$1" = "d" ] && v=$NVS_DEFAULT_VER

    resolved_ver="$(_nvs_cmd local_ls_one $v)"
    resolved_path=$NVS_V_DIR/$resolved_ver$NVS_NODE_BIN
    if [ ! -d "$resolved_path" ] || [ "$resolved_path" = "$NVS_V_DIR/" ]; then
        _nvs_log "Failed to resolve version '$v'. List of installed versions:"
        _nvs_cmd local_ls_all
    else
        [ "$1" != "d" ] && _nvs_log "Switching to version '$resolved_ver'..."
        # remove nvs from the PATH
        export PATH=$(echo $PATH | sed -E 's#:[^:]+/nvs/[^:]+##')
        # append resolved nodejs version to the PATH
        export PATH="$PATH:$resolved_path"
    fi
}


# ==============================================================================
# Cross-platform command aliases
# ==============================================================================
alias nvs='             _nvs_cmd info'
alias nvs-h='           _nvs_cmd help'

alias nvs-ls='          _nvs_cmd local_ls_all'
alias nvs-ls-one='      _nvs_cmd local_ls_one'

alias nvs-find='        _nvs_cmd remote_ls_all'
alias nvs-find-one='    _nvs_cmd remote_ls_one'

alias nvs-i='           _nvs_cmd install'

alias nvs-default-get=' _nvs_cmd default_get'
alias nvs-default-set=' _nvs_cmd default_set'

_nvs_cmd() {
    pushd $NVS_DIR >/dev/null
    bash scripts/_nvs_$1.sh $2
    popd >/dev/null
}


# ==============================================================================
# use default node version
# ==============================================================================
[ -z $NVS_NO_DEFAULT ] && nvs-use d
