#!/bin/bash

# set parameter
dir="."
input='.jpg'
timeshift='+07:00'
while getopts :d:i:t: flag
do
    case "${flag}" in
        d) dir=${OPTARG};;
        i) input=${OPTARG};;
        t) timeshift=${OPTARG};;
        :) echo "Option -$OPTARG requires an argument."; exit 1;;
        \?) echo "Invalid option: -$OPTARG"; exit 1;;
    esac
done

# count files
cnt=$(find ${dir} -maxdepth 1 -type f | sed -e 's/\(.*\)/\L\1/' | grep "${input,,}"'$' | wc -l)
echo "processing ${input} files total: ${cnt}"

# stamp gps time
i=0
for f in $(find ${dir} -maxdepth 1 -type f | sort);
do
    # lowercase + regex
    if [[ "${f,,}" =~ ${input,,}$ ]]
    then
        i=$(($i+1))
        echo "(${i}/${cnt}) ${f}"
        # write gps time
        if [ ${input,,} == ".mp4" ]
        then
            exiftool -q -m -overwrite_original '-XMP:GPSDatetime<${CreateDate}'"${timeshift}" $f
        else
            exiftool -q -m -overwrite_original '-GPSTimeStamp<${DateTimeOriginal}'"${timeshift}" '-GPSDateStamp<${DateTimeOriginal}'"${timeshift}" $f
        fi
    fi
done
