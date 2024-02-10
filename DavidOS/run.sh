#!/bin/bash

echo "Building"
make

echo "Running"
qemu-system-i386 -fda build/main_floppy.img

echo "del build map inside before running again!"
read -p "End"
