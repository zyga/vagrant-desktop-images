#!/bin/sh
# Refresh all boxes from what's made in the parent directory
BOXES="$*"
test -z "$BOXES" && BOXES="precise raring saucy trusty"
for series in $BOXES; do
    for arch in i386 amd64; do
        name=$series-desktop-$arch
        if [ -f ../$name.box ]; then
            echo "Reloading $name..."
            vagrant box remove $name
            vagrant box add $name ../$name.box
        fi
    done
done
