cd /var/lib/cachito/sources

my_array=( $(find . -type f -size +1G) )

for element_path in "${my_array[@]}"
  do
    wc -c $element_path
    tar -zxf $element_path --one-top-level 
    element=$(echo $element_path | rev | cut -d '/' -f1 | rev | cut -d '.' -f1)
    cd $element/app
    git gc
    cd ../..
    tar -czf $element_path $element
    wc -c $element_path
    #sleep 5
  done

