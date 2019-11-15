#!/usr/bin/env bash

clearData="true"
if [[ "$@" =~ "-persist" ]]; then
  clearData="false"
fi

if [[ "$clearData" == "true" ]]; then
  echo "Initializing Accumulo"
  hadoop fs -rm -r hdfs://namenode/accumulo
  echo "Sleeping for 5 seconds after deleting dir"
  sleep 5
fi

runuser -l accumulo -c '/opt/accumulo/current/bin/accumulo init --intance-name COMPOSE --password test --clear-instance-name'
echo "Init done"

echo "Starting Master"
runuser -l accumulo -c "/opt/accumulo/current/bin/start-all.sh"

echo "Wait 30 seconds before creating the user"
sleep 30

runuser -l accumul -c '/opt/accumulo/current/bin/accumulo-user.sh'

echo "Accumulo startup complete. Now tail a nonexistent file, to keep this container up"
tail -F /tmp/dontStop