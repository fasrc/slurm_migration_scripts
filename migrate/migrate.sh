#!/bin/bash

folderlist=$(ls -ltr /source/filesystem/ | awk '{{print $9}}')
#awk '{if ($3 =="root"){print $9}}')

echo $folderlist

for f in $folderlist
do
	echo $f
	FOLDER="$f" sbatch runscript-migrate
	#sleep 1s
done
