#!/bin/bash

status_code=$(curl --write-out %{http_code} --silent --output /dev/null http://localhost:8090/ABCtechnologies-1.0/)

if [[ "$status_code" -eq 200 ]] ; then
  echo "ABCtechnologies-1.0  status  $status_code"
else
  exit 0
fi
