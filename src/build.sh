#!/bin/sh
# this file build build boa with AFL++
# the boa directory should contain the source code, i.e., the root of the boa project
# at the end of this script, a boa-afl binary will be placed in the same directory
cd boa
make clean
./configure CC=afl-cc
make
cp ./src/boa ../boa-afl
