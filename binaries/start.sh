#!/bin/sh
# starts the boa server using preeny to make STDIN the socket inputs
# if binary is ran without preeny, it opens on localhost:3003
LD_PRELOAD=preeny/desock.so ./boa-afl -c ../boa_root
