#!/bin/bash

# Test semantics
cd build/
echo "Test YUML rendering"
for folder in "test" "train" "valid"
do
    for file in "pretty/$folder/"*.yuml
    do
        yuml -i $file -o pretty/last_render.png
        if [ $? -ne 0 ]
        then
            printf "${RED}Problem${NC} in $file\n"
            cat $file
            exit 1
        fi
    done
done