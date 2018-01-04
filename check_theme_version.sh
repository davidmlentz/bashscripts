#!/bin/sh

# For each site listed in data/sites, grab one page and parse it to find the version of the active WordPress theme.

i=1
while read line; do
	echo $line
	wget -qO - $line | grep "theme-version" | sed s/'<meta name="'//g | sed s/'" content="'/": "/g | sed s/'" \/>'//g | sed s/'theme-version'/'Framewerk version'/g
	wget -qO - $line | grep "wp-embed.min.js" | sed s/"<script type='text\/javascript' src='\(.*\)?ver="/"WP core version: "/g | sed s/"'><\/script>"//g
	echo "\r\n"
        sleep 1
done <data/sites
