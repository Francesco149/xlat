#!/bin/sh

bash ./build.sh release
cp -v ./build/release/xlat.elf .
./program.sh
