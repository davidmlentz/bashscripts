#!/bin/sh

i=1
while read line; do
	/usr/local/bin/pa11y --ignore 'warning;notice' --reporter html $line > ~/Desktop/accessibilityreports/$i.html
	echo "$i: $line\r\n"
	((i++))
    sleep 3
done <error_urls