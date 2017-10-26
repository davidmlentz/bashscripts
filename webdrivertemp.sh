#!/bin/sh

clear
echo "What site should we test?"
read TESTSITE
clear
echo "Got it. Testing ${TESTSITE}.boisestate.edu..."
`export TESTSITE=$TESTSITE`
~/node_modules/.bin/wdio ~/wdio.conf.js --spec temp.js
