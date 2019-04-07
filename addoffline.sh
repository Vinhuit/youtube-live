#!/bin/bash
while true
do
  if [ -z "$2" ]
  then
	  STATUS=$(curl -k -s -o /dev/null -w '%{http_code}' -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "[{\"device\":\"$DEVICE\"}]" "http://myjsonserver-winiss.1d35.starter-us-east-1.openshiftapps.com/offline")
	  node server.js &
  else
	  STATUS=$(curl -k -s -o /dev/null -w '%{http_code}' -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "[{\"key\":\"$1\",\"link\":\"$2\",\"device\":\"$3\"}]" "http://myjsonserver-winiss.1d35.starter-us-east-1.openshiftapps.com/online")
  fi
  if [ $STATUS -eq 201 ]; then
    echo "Got 201! All done!"
    break
  else
    echo "Got $STATUS :( Not done yet..."
  fi
  sleep 1
done
