#!/bin/sh
# starts the boa server using preeny to make STDIN the socket inputs
# if binary is ran without preeny, it opens on localhost:3003
# the first command line argument will be the number of fuzzing instances
# might use libdesocket instead of preeny
# https://lolcads.github.io/posts/2022/02/libdesock/
# PREENY_INFO=1 PREENY_ERROR=1 PREENY_DEBUG=1 LD_PRELOAD=./binaries/preeny/desock_dup.so ./binaries/boa-afl -c ./boa_root
# probably want to fix the AFL_SKIP_CPUFREQ hack for real fuzzing (i.e., get
#   rid of the variable and follow the instructions)
if [ $# -eq 0 ]
then
    AFL_SKIP_CPUFREQ=1 AFL_PRELOAD=./binaries/preeny/desock.so afl-fuzz -i ./afl/seeds_dir -o ./afl/output_dir -- ./binaries/boa-afl -c ./boa_root
else
    AFL_SKIP_CPUFREQ=1 AFL_PRELOAD=./binaries/preeny/desock.so afl-fuzz -i ./afl/seeds_dir -o ./afl/sync_dir -M fuzzer01 -- ./binaries/boa-afl -c ./boa_root &
    instances=$(( $1 ))
    for i in $(seq 1 $instances)
    do
        name="fuzzer0$instances"
        AFL_SKIP_CPUFREQ=1 AFL_PRELOAD=./binaries/preeny/desock.so afl-fuzz -i ./afl/seeds_dir -o ./afl/sync_dir -M $name -- ./binaries/boa-afl -c ./boa_root &
    done
fi
