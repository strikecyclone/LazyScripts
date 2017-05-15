#!/bin/bash

# check number of params
if [ $# -gt 2 -o $# -lt 1 ];then
  echo "Usage: <file> [<url>]"
  exit 0
fi

url='http://localhost:8080/solr/zero'

if [ $# -eq 2 ];then
  url=$2
fi

cat $1 | while read line
do
  id=`echo $line|cut -d " " -f 1`
  boost=`echo $line|cut -d " " -f 2`
  curl $url/update -H 'Content-type:application/json' -d '[{"id":"'$id'","boost":{"set":'$boost'}}]'
done

curl $url/update --data-binary "<commit/>" -H 'Content-type:text/xml; charset=utf-8'
