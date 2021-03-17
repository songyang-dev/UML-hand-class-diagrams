#!/bin/bash

# Renders a yuml file to last_render.png
if [ $# -ne 1 ]; then
    echo "Usage: ./render.sh file.yuml"
    exit 1
fi

yuml -i $1 -o last_render.png