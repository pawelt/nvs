#!/usr/bin/env bash

source $NVS_DIR/scripts/_nvs_common.sh

node_ver=$(node -v 2>/dev/null || echo '(no version found)')
echo "Node Version Switcher v$NVS_VER  /  NodeJS $node_ver"
echo ""
echo "Commands:"
echo "  nvs-use [v]         activate the newest installed version matching the filter"
echo "  nvs-ls [v]          list installed node versions with optional filter"
echo ""
echo "  nvs-h               more help and commands"
echo ""
echo "Install and configure the latest version of node:"
echo "  nvs-i && nvs-use && nvs-default-set"
