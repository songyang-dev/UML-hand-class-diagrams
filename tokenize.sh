#!/bin/bash

# Tokenizes the data set and stores the results in the given directory
if [ $# -ne 1 ]
then
    echo "Usage: ./tokenize.sh folder-where-to-store #to run the data set"
    echo "Usage: ./tokenize.sh one-yuml-file #to output a tokenization"
    exit 1
fi

if [ -d "$1" ]
then
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
else
    ./tokenizer/build/yuml_tokenizer.exe < "$1"
fi