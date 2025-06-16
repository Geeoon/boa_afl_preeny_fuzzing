#!/bin/sh
# starts the boa server using preeny to make STDIN the socket inputs
# if binary is ran without preeny, it opens on localhost:3003
# the first command line argument will be the number of fuzzing instances
# might use libdesocket instead of preeny
# https://lolcads.github.io/posts/2022/02/libdesock/
# PREENY_INFO=1 PREENY_ERROR=1 PREENY_DEBUG=1 LD_PRELOAD=./binaries/preeny/desock_dup.so ./binaries/boa-afl -c ./boa_root
# probably want to fix the AFL_SKIP_CPUFREQ hack for real fuzzing (i.e., get
#   rid of the variable and follow the instructions)

# preeny desock preload
PRELOAD=./binaries/preeny/desock.so

if [ $# -eq 0 ]
then
    AFL_SKIP_CPUFREQ=1 AFL_PRELOAD=$PRELOAD afl-fuzz -i ./afl/seeds_dir -o ./afl/output_dir -- ./binaries/boa-afl -c ./boa_root
else
    instances=$(( $1 ))

    if [ $instances -lt 2 ]
    then
        echo Specified less than 2 instances. Please run the script without command line parameters.
        exit 1
    fi
    
    AFL_SKIP_CPUFREQ=1 AFL_PRELOAD=$PRELOAD afl-fuzz -i ./afl/seeds_dir -o ./afl/sync_dir -M fuzzer01 -- ./binaries/boa-afl -c ./boa_root &
    for i in $(seq 2 $instances)
    do
        name="fuzzer0$i"
        AFL_SKIP_CPUFREQ=1 AFL_PRELOAD=$PRELOAD afl-fuzz -i ./afl/seeds_dir -o ./afl/sync_dir -S $name -- ./binaries/boa-afl -c ./boa_root > /dev/null &
    done
    # NOTE: run pkill boa to stop all fuzzers
fi
