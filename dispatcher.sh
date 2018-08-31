#!/bin/bash

. ./configuration.cnf

echo $STATUS_SERVER_URL

res=$(curl -s localhost:12345/next.php)

if [ "$res" == "IDLE" ]; then
  echo "we can start mongo"
  # start mongo export
  # curl -X POST -d 'MONGO_EXPORT:STARTED' localhost:12345/status.php
  # cd 
  # nohup ./europeana-qa-spark/run-mongo-to-json.sh > run-mongo-to-json.log
  # curl -X POST -d 'MONGO_EXPORT:FINISHED' localhost:12345/status.php
elif [ "$res" == "MONGO_EXPORT:FINISHED" ]; then
  echo "we can start mongo upload"
else
  echo $res
fi

