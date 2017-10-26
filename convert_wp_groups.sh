#!/bin/sh

cd /Users/davidlentz/temp/WPGroups
for file in *.txt; do
    iconv -f utf-16 -t ascii "$file" > "/Users/davidlentz/temp/WPGroups/converted/${file}"
done
