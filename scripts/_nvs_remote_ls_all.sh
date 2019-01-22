#!/usr/bin/env bash

# filter out versions older than 5
curl -s https://nodejs.org/dist/ \
    | sed -E 's#("v)([0-9])\.#\10\2.#' \
    | sed -E 's#("v[0-9]+\.)([0-9])\.#\10\2.#' \
    | sed -E 's#("v[0-9]+\.[0-9]+\.)([0-9])/#\10\2/#' \
    | sort -r | grep -oE '>v([5-9]|1[0-9])[^/<]+' \
    | grep -oE '[0-9]+.[0-9]+.[0-9]+' \
    | grep "^$1"
