#!/bin/bash -e

for file in debian/*
do
    if [[ -f $file ]]; then
        echo "Tsau"
    fi
done