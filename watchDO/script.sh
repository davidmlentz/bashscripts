#!/bin/bash
rm -rf write-for-digitalocean
wget https://www.digitalocean.com/community/write-for-digitalocean
grep '<div class="do-form disabled">' write-for-digitalocean
result=$?
if [[ $result -eq 0 ]]; then
	echo 'ZERO' # Div is present. Not accepting submissions. Do nothing.
else
	echo 'MORE THAN ZERO' # Div is gone! Text me
	echo "Check this page: https://www.digitalocean.com/community/write-for-digitalocean . They may be accepting submissions again." > message.txt
	/usr/local/bin/aws sns publish --topic-arn "arn:aws:sns:us-east-1:xxxxxxxxxxxx:CheckDO" --message file://message.txt
fi
