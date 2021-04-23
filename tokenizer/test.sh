#!/bin/bash

# Tests the parser for correct input

RED='\033[0;31m'
NC='\033[0m' # No Color            

cd build

echo "Test parsing on negative examples"
for file in ../negatives/*.yuml
do
    ./yuml_tokenizer.exe < $file &> /dev/null
    if [ $? -eq 0 ]
    then
        printf "${RED}Problem${NC} in $file\n"
    fi
done

echo "Test parsing on data set"
# prepare pretty output
mkdir -p pretty/train pretty/test pretty/valid

for folder in "test" "train" "valid"
do
    for file in "../../$folder/"*.yuml
    do
        ./yuml_tokenizer.exe < $file > pretty/$folder/$(basename $file)
        if [ $? -ne 0 ]
        then
            printf "${RED}Problem${NC} in $file\n"
            cat $file
            exit 1
        fi
    done
done

echo "Test pretty printer"
for folder in "test" "train" "valid"
do
    for file in "pretty/$folder/"*.yuml
    do
        ./yuml_tokenizer.exe < $file > pretty/temp.yuml
        if [ $? -ne 0 ]
        then
            printf "${RED}Problem${NC} in $file\n"
            cat $file
            exit 1
        fi

        # Test equality
        if ! cmp -s "$file" pretty/temp.yuml; then
            printf "${RED}Error${NC}: Pretty invariant violated for $file. Output in pretty/temp.yuml"
            exit 1
        fi
    done
done
