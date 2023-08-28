#!/usr/bin/env bash

echo -n "Checking file count... "
file_count=$(ls -A build/ | wc -l)
if [[ $file_count -eq 196 ]]; then
    echo -e "\xE2\x9C\x94"
else
    echo -e $"\u274c"
    echo "    - Expected 196 files but found $file_count"
fi


declare -A expected_sizes

for size in 132x132 132x70 264x139 264x264 44x23 44x44 84x45 84x84; do
    expected_sizes["$size"]=1
done


sizes=$(identify build/* | grep -oP "PNG.+?\+" | cut -d " " -f 2 | sort -u)
echo -n "Checking icon resolutions... "
pass=1

while read size; do
    if [[ ! ${expected_sizes["$size"]} ]]; then
        pass=0
        failure="$size"
    fi
done <<< $sizes

if [[ $pass -eq 1 ]]; then
    echo -e "\xE2\x9C\x94"
else
    echo -e $"\u274c"
    echo "    - Unexpected size $failure found"
fi


