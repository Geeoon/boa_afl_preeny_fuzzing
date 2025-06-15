#!/bin/sh
# starts the boa server using preeny to make STDIN the socket inputs
# if binary is ran without preeny, it opens on localhost:3003
# might use libdesocket instead of preeny
# https://lolcads.github.io/posts/2022/02/libdesock/
# PREENY_INFO=1 PREENY_ERROR=1 PREENY_DEBUG=1 LD_PRELOAD=./binaries/preeny/desock_dup.so ./binaries/boa-afl -c ./boa_root
LD_PRELOAD=./binaries/preeny/desock.so ./binaries/boa-afl -c ./boa_root
