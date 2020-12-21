#cd /var/lib/cachito/sources
cd var/lib/cachito/sources
#find . -type f -size +10M

my_array=( $(find . -type f) )

for element_path in "${my_array[@]}"
  do
    echo "${element_path}"
    wc -c $element_path
    tar -zxf $element_path --one-top-level 
    element=$(echo $element_path | rev | cut -d '/' -f1 | rev | cut -d '.' -f1)
    echo $element

    sleep 5
    cd $element/app
    pwd
    #git gc

    sleep 5
    cd ../..
    tar -czf $element_path $element
    wc -c $element_path
  done

