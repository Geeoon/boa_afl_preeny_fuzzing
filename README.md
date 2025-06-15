# Fuzzing the Boa web server using AFL++ and Preeny
## Prerequisites
### AFL++
1. Install AFL++ onto your machine.

2. Ensure AFL++ is installed by running `which afl-cc` and `which afl-fuzz`.

### Boa
1. In the src directory, place the desired version of Boa to fuzz into a directory named `boa`.

2. Run the build script (in the src directory) with `./build.sh`.

### Preeny
The preeny library files are included in the project in the binaries/preeny directory.

## Fuzzing
Run the fuzzer with `./start.sh`.

For multiple instances, specify the number of fuzzers as the first command line argument.  Ex: `./start.sh 4`.