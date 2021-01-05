#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


sources_dir="/var/lib/cachito/sources/"
cd $sources_dir

my_array=( $(find . -type f -size +1G) )
dest_dir="/tmp/"

for element_path in "${my_array[@]}"
  do
    echo "Before: $(wc -c $element_path)"
    tar -zxf $element_path --one-top-level=$dest_dir
    element=$(basename  $element_path .tar.gz)
    pushd $dest_dir 1> /dev/null
    pushd $dest_dir$element/app 1> /dev/null
    git gc --prune=now --quiet
    popd 1> /dev/null
    tar -czf $sources_dir$element_path $element
    rm -rf ${element}
    popd 1> /dev/null
    echo "After: $(wc -c $element_path)"
    echo
    #sleep 5
  done

