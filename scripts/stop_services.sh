#!/bin/sh
$KAFKA_PATH/bin/kafka-server-stop.sh
sleep 2
$KAFKA_PATH/bin/zookeeper-server-stop.sh 

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
bash "$DIR"/stop_elasticsearch.sh
bash "$DIR"/stop_alarm_server.sh
bash "$DIR"/stop_alarm_logger.sh
bash "$DIR"/stop_alarm_config_logger.sh