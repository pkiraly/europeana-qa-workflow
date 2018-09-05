#!/bin/bash

. ./configuration.cnf

function launch_mongo_export () {
  # start mongo export
  change_status 'MONGO_EXPORT:STARTED'
  cd ../europeana-qa-spark
  nohup ./europeana-qa-spark/run-mongo-to-json.sh > run-mongo-to-json.log
}

function launch_mongo_export_download () {
  cd ../europeana-qa-spark
  php mongo-hdfs-to-fs-launcher.php >> launch-report.log
}

function launch_mongo_upload () {
  change_status 'MONGO_UPLOAD:STARTED'
  VERSION=$(get_version)
  cd $ROOT_EXPORT_DIR/v${VERSION}/full
  hdfs dfs -put *.json.gz $HDFS_SOURCE_DIR
}

function launch_spark_completeness () {
  exit
}

function launch_spark_saturation () {
  exit
}

function launch_spark_language () {
  exit
}

function launch_split_completeness () {
  exit
}

function launch_split_saturation () {
  exit
}

function launch_r_completeness () {
  exit
}

function launch_r_saturation () {
  exit
}

function change_status () {
  status=$1
  curl -s -X POST -d '$status' $STATUS_SERVER_URL/status.php
}

function get_version () {
  version=$(curl -s $STATUS_SERVER_URL/version.php)
  return $version
}

echo $STATUS_SERVER_URL

status=$(curl -s $STATUS_SERVER_URL/status.php)

if [ "$status" == "IDLE" ]; then
  echo "we can start mongo"
  launch_mongo_export
elif [ "$status" == "MONGO_EXPORT:STARTED" ]; then
  echo "we can start mongo upload"
  launch_mongo_export_download
  # check if it still running then
  #   change_status 'MONGO_EXPORT:FINISHED'

elif [ "$status" == "MONGO_EXPORT:FINISHED" ]; then
  echo "we can start mongo upload"
  launch_mongo_upload
elif [ "$status" == "MONGO_UPLOAD:STARTED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "MONGO_UPLOAD:FINISHED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "SPARK_COMPLETENESS:STARTED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "SPARK_COMPLETENESS:FINISHED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "SPARK_SATURATION:STARTED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "SPARK_SATURATION:FINISHED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "SPARK_LANGUAGE:STARTED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "SPARK_LANGUAGE:FINISHED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "SPLIT_COMPLETENESS:STARTED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "SPLIT_COMPLETENESS:FINISHED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "SPLIT_SATURATION:STARTED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "SPLIT_SATURATION:FINISHED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "R_COMPLETENESS:STARTED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "R_COMPLETENESS:FINISHED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "R_SATURATION:STARTED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "R_SATURATION:FINISHED" ]; then
  echo "we can start mongo upload"
elif [ "$status" == "FINISHED" ]; then
  echo "we can start mongo upload"
else
  echo $status
fi

