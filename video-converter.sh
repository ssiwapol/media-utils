#!/bin/bash

# set parameter
dir="."
input='.mts'
output='.mp4'
compress='false'
timeshift='+0'
while getopts :d:i:o:t:c flag
do
    case "${flag}" in
        d) dir=${OPTARG};;
        i) input=${OPTARG};;
        o) output=${OPTARG};;
        t) timeshift=${OPTARG};;
        c) compress='true';;
        :) echo "Option -$OPTARG requires an argument."; exit 1;;
        \?) echo "Invalid option: -$OPTARG"; exit 1;;
    esac
done

# count files
cnt=$(find ${dir} -maxdepth 1 -type f | sed -e 's/\(.*\)/\L\1/' | grep "${input,,}"'$' | wc -l)
echo "processing ${input} files total: ${cnt}"

# convert video files
i=0
for f in $(find ${dir} -maxdepth 1 -type f | sort);
do
    # lowercase + regex
    if [[ "${f,,}" =~ ${input,,}$ ]]
        then
            i=$(($i+1))
            echo "(${i}/${cnt}) ${f} >> ${f%.*}$output"
            if [ $compress == "true" ]
                then
                    fps=$(mediainfo $f --Inform="Video;%FrameRate%")
                    fps=$(printf "%.0f" $fps)
                    ffmpeg -loglevel panic -i $f -c:v libx264 -c:a aac -crf 22 -preset medium -profile:v high -x264-params keyint=$(($fps*2)) ${f%.*}$output
                else
                    ffmpeg -loglevel panic -i $f -c:v libx264 -c:a aac -crf 17 -preset medium ${f%.*}$output
            fi
            # write date metadata
            exiftool -q -m -overwrite_original -api QuickTimeUTC -GlobalTimeShift $timeshift -TagsFromFile $f \
            "-DateTimeOriginal>CreateDate" "-DateTimeOriginal>ModifyDate" \
            "-DateTimeOriginal>TrackCreateDate" "-DateTimeOriginal>TrackModifyDate" \
            "-DateTimeOriginal>MediaCreateDate" "-DateTimeOriginal>MediaModifyDate" \
            ${f%.*}$output
    fi
done
