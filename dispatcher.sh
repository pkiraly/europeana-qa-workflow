#!/bin/bash

. ./configuration.cnf

echo $STATUS_SERVER_URL

status=$(curl -s $STATUS_SERVER_URL/status.php)

if [ "$status" == "IDLE" ]; then
  echo "we can start mongo"
  # start mongo export
  # curl -X POST -d 'MONGO_EXPORT:STARTED' localhost:12345/status.php
  # cd ../europeana-qa-spark
  # nohup ./europeana-qa-spark/run-mongo-to-json.sh > run-mongo-to-json.log
  # curl -X POST -d 'MONGO_EXPORT:FINISHED' localhost:12345/status.php
  # php mongo-hdfs-to-fs-launcher.php >> launch-report.log
elif [ "$status" == "MONGO_EXPORT:FINISHED" ]; then
  echo "we can start mongo upload"
else
  echo $status
fi

