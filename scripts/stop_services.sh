#!/bin/sh
$KAFKA_PATH/bin/kafka-server-stop.sh
sleep 5
$KAFKA_PATH/bin/zookeeper-server-stop.sh 