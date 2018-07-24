#!/usr/bin/env bash

curl -s https://nodejs.org/dist/ \
    | sed -E 's#("v)([0-9])\.#\10\2.#' \
    | sed -E 's#("v[0-9]+\.)([0-9])\.#\10\2.#' \
    | sed -E 's#("v[0-9]+\.[0-9]+\.)([0-9])/#\10\2/#' \
    | sort -r | grep -oE '>v(5|6|7|8|9|10)[^/<]+' | grep -oE '[0-9]+.[0-9]+.[0-9]+' \
    | grep "^$1"
