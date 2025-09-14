#!/bin/bash

# Directory where the files are located
directory="$1"

number="$2"

subdir="./test_${number}"
mkdir ${directory}/test_${number}

for file in "$directory"/*; do
    if [ -f "$file" ]; then
    	basefile=$(basename "$file")
	extension="${basefile##*.}"
	filename="${basefile%.*}"
	new_name="${filename}_${number}.${extension}"
	mv "$file" "${directory}/${subdir}/$new_name"
	echo "Renamed: $basefile -> $new_name"
    fi
done
