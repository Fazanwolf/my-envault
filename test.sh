#!/bin/bash

engine="Ubuntu"

checkInstalled()
{
    $1
    if [[ $? -eq 127 ]]; then
        return -1;
    fi
    return 0;
}

checkInstalled "php --version"
if [[ $? -eq -1 ]]; then
    echo "LETGO!"
else
    echo "EHHH?"
fi