#!/bin/bash
set -euo pipefail
IFS=$'\n\t'


sources_dir="/var/lib/cachito/sources/"
cd $sources_dir

my_array=( $(find . -type f -size +1G) )
dest_dir="/tmp/cloudbld-3454/"
mkdir $dest_dir

echo "START"

for element_path in "${my_array[@]}"
  do
    echo "Before: $(wc -c $element_path)"
    element=$(basename  $element_path .tar.gz)
    element_dest_dir=$dest_dir$element
    mkdir $element_dest_dir
    tar -zxf $element_path -C $element_dest_dir 
    pushd $dest_dir 1> /dev/null
    pushd $element_dest_dir 1> /dev/null
    pushd ./app 1> /dev/null
    git gc --prune=now --quiet
    popd 1> /dev/null
    tar -czf $sources_dir$element_path *
    popd 1> /dev/null
    rm -rf ${element}
    popd 1> /dev/null
    echo "After: $(wc -c $element_path)"
    echo
  done

echo "END"
