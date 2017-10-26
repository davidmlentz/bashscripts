#!/bin/sh
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

cd /Users/davidlentz/Documents/git_repos/tests
git pull
rm -rf /Users/davidlentz/tests
mkdir -p /Users/davidlentz/tests/results/temp
cd ..
cp -R tests /Users/davidlentz/.
cd /Users/davidlentz
/usr/local/bin/node tests/aae_homepage_test.js > tests/results/temp/aae_homepage_test_output.txt

if (( $(grep -c 'Page has a title tag' tests/results/temp/aae_homepage_test_output.txt) == 0 )); then
        mv tests/results/temp/aae_homepage_test_output.txt tests/results/temp/ERROR_NOT_FOUND_aae_homepage_test_output.txt
        open /Users/davidlentz/tests/results/temp
elif grep -qci 'error' tests/results/temp/aae_homepage_test_output.txt; then
        mv tests/results/temp/aae_homepage_test_output.txt tests/results/temp/ERROR_aae_homepage_test_output.txt
        open /Users/davidlentz/tests/results/temp
else
        mv tests/results/temp/aae_homepage_test_output.txt tests/results/temp/OK_aae_homepage_test_output.txt
fi

RESULT=`/usr/local/bin/node tests/oit_homepage_test.js`
#if (( $(grep -c 'Page has a title tag' $RESULT) == 0 )); then
if echo "$RESULT" | grep -Lq 'Page has a title tag'; then
	echo $RESULT > tests/results/temp/ERROR_NOT_FOUND_oit_homepage_test_output.txt
	open /Users/davidlentz/tests/results/temp
#elif grep -qci 'error' $RESULT; then
elif echo "$RESULT" | grep -qi 'error'; then
	echo $RESULT > tests/results/temp/ERROR_oit_homepage_test_output.txt
	open /Users/davidlentz/tests/results/temp
else
	echo $RESULT > tests/results/temp/OK_oit_homepage_test_output.txt
fi
