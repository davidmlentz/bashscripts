#!/bin/sh

cd /Users/davidlentz/temp/WPGroups/converted
touch alluserstemp
for file in *.txt; do
	users=`cat "$file" | wc -l | tr -d '[:space:]'`
	if [[ "$users" -gt 6 ]]; then
		echo "${file} has ${users} users"
		cat $file >> alluserstemp
	fi
done

# Get rid of duplicates:
cat alluserstemp | sort | uniq > allusers
