#!/bin/sh
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
suite=$1
# TESTSITE=$2
# `export TESTSITE=$TESTSITE`
reportpath="/Users/davidlentz/Desktop/webdriver_reports"
reportname="${reportpath}/webdriverio_results_${suite}_$(date +%Y%m%d%H%M).txt"
errorname="${reportpath}/ERROR_webdriverio_results_${suite}_$(date +%Y%m%d%H%M).txt"
okname="${reportpath}/OK_webdriverio_results_${suite}_$(date +%Y%m%d%H%M).txt"

cd /Users/davidlentz/Documents/git_repos/tests
git pull

cd /Users/davidlentz
./node_modules/.bin/wdio wdio.conf.js --suite $suite > $reportname

if grep -qci 'error' ${reportname}; then
        mv ${reportname} ${errorname}
        open ${reportpath}
else
	mv ${reportname} ${okname}
fi

aws s3 sync ${reportpath} s3://boisestateaccessibilityscan/webdriver
