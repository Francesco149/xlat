#!/bin/sh

act  --artifact-server-path ./artifacts
7z -y x ./artifacts/1/firmware/firmware.zip
./program.sh
