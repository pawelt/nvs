#!/usr/bin/env bash

echo $(source scripts/_nvs_remote_ls_all.sh $1 | grep -m 1 '')
