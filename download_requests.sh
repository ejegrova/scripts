host="localhost:8080/api/v1/requests"

for (( id=1 ; id<=50 ; id++ ))
do
    wget $host/$id/download -O download_$id.tar.gz
    sleep 10 
done
