#!/bin/sh

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

cd ~/Documents/git_repos/tests
git pull
rm -rf ~/tests
mkdir -p ~/tests/results
cd ..
cp -R tests ~/.
cd

errorsites=''

for file in `ls ~/Documents/git_repos/tests`
do
	if [[ $file == *"_test.js" ]] ;then 
		site=`echo $file | sed 's/_.*$//'`
		outputdir=tests/results
		testoutput=${outputdir}/${site}_output.txt
		missingoutput=${outputdir}/ERROR_NOT_FOUND_${site}_output.txt
		erroroutput=${outputdir}/ERROR_${site}_output.txt
		okoutput=${outputdir}/OK_${site}_output.txt

		/usr/local/bin/node tests/${file} > $testoutput

		if (( $(grep -c 'Page has a title tag' $testoutput) == 0 )); then
			mv $testoutput $missingoutput
			errorsites="${errorsites}\n$site"
			open ${outputdir}
		elif grep -qci 'error' $testoutput; then
			mv $testoutput $erroroutput
			errorsites="${errorsites}\n$site"
			open ${outputdir}
		else
			mv $testoutput $okoutput
		fi
	fi
done

if [[ ! -z "$errorsites" ]]; then
	echo "WP tests failed on the following sites: $errorsites" > errorfile
	aws sns publish --topic-arn "arn:aws:sns:us-east-1:XXXXXXXXXXXX:test" --message file://errorfile
	#rm errorfile
fi

#aws s3 sync --delete tests/results s3://boisestateaccessibilityscan/webdriver/results_new
