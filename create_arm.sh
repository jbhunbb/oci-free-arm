#!/bin/bash

config='./config.json'

#Read config json
displayName=`jq -r '.displayName' $config`
subnetId=`jq -r '.createVnicDetails.subnetId' $config`
availabilityDomain=`jq -r '.availabilityDomain' $config`
shape=`jq -r '.shape' $config`
compartmentId=`jq -r '.compartmentId' $config`
imageId=`jq -r '.sourceDetails.imageId' $config`
assignPublicIp=`jq -r '.createVnicDetails.assignPublicIp' $config`

# Can't Use Single Quote
jq '.metadata' $config > ./etc_json/metadata.json
jq '.shapeConfig' $config > ./etc_json/shapeConfig.json


while :
do
    oci compute instance launch \
    --display-name $displayName \
    --subnet-id $subnetId \
    --availability-domain $availabilityDomain \
    -c $compartmentId \
    --image-id $imageId \
    --shape $shape \
    --shape-config file://etc_json/shapeConfig.json \
    --metadata file://etc_json/metadata.json \
    --assign-public-ip $assignPublicIp \
    --no-retry \
    --debug > latest.log

date=`date +"%Y-%m-%d %T"`
resCheck=`grep -c "200 OK" latest.log`
if [ $resCheck -gt 0 ] ; then
    echo "$date 200 OK! Creating Success!" >> full_log.log
    break
fi
    
    errmsg=`grep "reply" latest.log`
    echo "$date Failed! $errmsg" >> full_log.log
    sleep 30
done