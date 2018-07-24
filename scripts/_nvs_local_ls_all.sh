#!/usr/bin/env bash

ls -d $(pwd)/v/*/ 2>/dev/null | grep -oE '[0-9][^/]+' \
    | sed -E 's#(.+)#v\1  \1#' \
    | sed -E 's#(v)([0-9])\.#\10\2.#' \
    | sed -E 's#(v[0-9]+\.)([0-9])\.#\10\2.#' \
    | sed -E 's#(v[0-9]+\.[0-9]+\.)([0-9])#\10\2#' \
    | sort -r | grep -oE ' .+' | grep -oE '[0-9]+.[0-9]+.[0-9]+' \
    | grep "^$1"