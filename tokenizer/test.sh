#!/bin/bash

# Tests the parser for correct input

RED='\033[0;31m'
NC='\033[0m' # No Color            

cd build

for file in ../negatives/*.yuml
do
    ./yuml_tokenizer.exe < $file &> /dev/null
    if [ $? -eq 0 ]
    then
        printf "${RED}Problem${NC} in $file\n"
    fi
done

for folder in "test" "train" "valid"
do
    for file in "../../$folder/"*.yuml
    do
        ./yuml_tokenizer.exe < $file > /dev/null
        if [ $? -ne 0 ]
        then
            printf "${RED}Problem${NC} in $file\n"
            exit 1
        fi
    done
done