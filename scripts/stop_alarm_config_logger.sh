#!/bin/bash
SIGNAL=${SIGNAL:-TERM}

OSNAME=$(uname -s)
if [[ "$OSNAME" == "OS/390" ]]; then
    PIDS=$(ps -A -o pid,jobname,comm | grep -i alarm-config-logger | grep java | grep -v grep | awk '{print $1}')
elif [[ "$OSNAME" == "OS400" ]]; then
    PIDS=$(ps -af | grep -i 'alarm-config-logger' | grep java | grep -v grep | awk '{print $2}')
else
    PIDS=$(ps ax | grep 'alarm-config-logger' | grep java | grep -v grep | awk '{print $1}')
fi

if [ -z "$PIDS" ]; then
  echo "No alarm config logger to stop"
  exit 1
else
  kill -s $SIGNAL $PIDS
fi
