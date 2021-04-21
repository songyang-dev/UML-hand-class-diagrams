#!/bin/bash

# Don't run this if you have problems with setting up flex+bison

# If no compilation has been done

    mkdir build
    make clean  # will remove all flex and bison C files!
    make
    cd build
    cmake ..
    make
    cd ..
