#!/bin/bash
function makefile() {
	mypath=$(echo $1 | cut -d "=" -f1)
	mycontent=$(echo -e $1 | cut -d "=" -f2-)

}

function gitdeploy() {
#	Check if $URL has SSH or not, enable support for keys using secrets and so on
	git clone "$URL"

}

function unpack() {
	#	Download file
	wget -q --no-check-certificate "$URL"
	filename=$(ls)
	if [ -z "$filename" ]
	then
		echo "Failed to download '$URL'? no file..."
		exit 1
	fi

	#	Uncompress file
	if [ $(file $filename | grep -c "Zip archive data") -eq 1 ]
	then
		unzip $filename
	else
		tar xf $filename
	fi

	rm $filename

}


