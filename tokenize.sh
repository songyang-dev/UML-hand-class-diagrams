#!/bin/bash

# Tokenizes the data set and stores the results in the given directory
if [ $# -ne 1 ]
then
    echo "Usage: ./tokenize.sh where-to-store"
    exit 1
fi

mkdir -p "$1/test"
mkdir -p "$1/train"
mkdir -p "$1/valid"
for folder in "test" "train" "valid"
do
    for file in $folder/*.yuml
    do
        ./tokenizer/build/yuml_tokenizer.exe < $file > "$1/$folder/$(basename $file)"
    done
done