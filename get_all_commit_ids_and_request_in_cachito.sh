host="localhost:8080/api/v1/requests"

my_array=( $(git log | grep ^commit | awk 'NF>1{print $NF}') )


for element in "${my_array[@]}"
do
   echo "${element}"
done


for (( idx=${#my_array[@]}-1 ; idx>=0 ; idx-- )) ; do
    echo "${my_array[idx]}"
done


for (( idx=${#my_array[@]}-1 ; idx>=0 ; idx-- ))
do
    curl -X POST -u : --negotiate -H "Content-Type: application/json" $host -d     '{
       "repo": "https://github.com/release-engineering/retrodep.git",
       "ref": "'"${my_array[idx]}"'",
       "pkg_managers": ["gomod"]
     }'
    
    sleep 7s
done
