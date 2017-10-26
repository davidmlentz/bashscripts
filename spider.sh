#!/bin/bash

# From https://gist.github.com/azhawkes/8404931

HOME="https://oit.boisestate.edu/"
DOMAINS="oit.boisestate.edu"
DEPTH=2
OUTPUT="./urls.csv"

wget -r --spider --delete-after --force-html -D "$DOMAINS" -l $DEPTH "$HOME" 2>&1 \
    | grep '^--' | awk '{ print $3 }' | grep -v '\. \(css\|js\|png\|gif\|jpg\)$' | sort | uniq > $OUTPUT
