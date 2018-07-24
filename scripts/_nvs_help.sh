#!/usr/bin/env bash

source $NVS_DIR/scripts/_nvs_common.sh

node_ver=$(node -v 2>/dev/null || echo '(no version found)')
echo "Node Version Switcher v$NVS_VER  /  NodeJS $node_ver"
echo ""
echo "Commands:"
echo "  nvs-use [v]         activate the newest installed version matching the filter"
echo ""
echo "  nvs-ls [v]          list installed node versions with optional filter"
echo "  nvs-ls-one [v]      same as nvs-ls, but prints only the first version found"
echo ""
echo "  nvs-find [v]        list available node versions with optional filter"
echo "  nvs-find-one [v]    same as nvs-find, but prints only the first version found"
echo ""
echo "  nvs-i [v]           installs the newest version matching the filter"
echo ""
echo "  nvs-default-get     print currently set default version"
echo "  nvs-default-set     save currently active version as default"
echo ""
echo "Filters:"
echo "  All [v] filters are partial or full versions, ex.:  8  9.1  10.7.0"
echo "  Empty [v] filter means 'match all versions'"
echo ""
echo "Install and configure the latest version of node:"
echo "  nvs-i && nvs-use && nvs-default-set"
echo ""
echo "To uninstall a version simply remove its directory from $NVS_DIR/v"
