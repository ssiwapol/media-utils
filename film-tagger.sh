#!/bin/bash

# set parameter
dir="."
suffix='.jpg'
film='false'
while getopts :j:d:s:f flag
do
    case "${flag}" in
        j) json=${OPTARG};;
        d) dir=${OPTARG};;
        s) suffix=${OPTARG};;
        f) film='true';;
        :) echo "Option -$OPTARG requires an argument."; exit 1;;
        \?) echo "Invalid option: -$OPTARG"; exit 1;;
    esac
done

if [ -z "$json" ]; then
    echo "Unimplemented option: -j"
    exit 1
fi

# count files
cnt=$(find ${dir} -maxdepth 1 -type f | sed -e 's/\(.*\)/\L\1/' | grep "${suffix,,}"'$' | wc -l)
echo "processing ${suffix} files total: ${cnt}"

# check film
if [ $film == "true" ]; then
    # retrieve data from json
    camera_make=$(jq -r .camera_make $json)
    camera_model=$(jq -r .camera_model $json)
    film_make=$(jq -r .film_make $json)
    film_type=$(jq -r .film_type $json)
    film_iso=$(jq -r .film_iso $json)
    # create json file
    jq -n "{Make: \"${camera_make}\", \
            Model: \"${camera_model}\", \
            ISO: \"${film_iso}\", \
            UserComment: \"-Make=${camera_make}\n-Model=${camera_model}\n-ISO=${film_iso}\nFilm Make: ${film_make}\nFilm Type: ${film_type}\", \
            Keywords: \"${camera_make}, ${camera_model}, ${film_iso}, ${film_make}, ${film_type}\"
            }"  > temp.json
    json=temp.json
fi

# edit metadata
i=0
for f in $(find ${dir} -maxdepth 1 -type f | sort);
do    
    # lowercase + regex
    if [[ "${f,,}" =~ ${suffix,,}$ ]]; then
        i=$(($i+1))
        echo "(${i}/${cnt}) ${f}"
        exiftool -q -overwrite_original -sep ", " -json=$json $f
    fi
done

# remove temp.json if exists
rm -f temp.json
