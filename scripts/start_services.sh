#!/bin/sh

$KAFKA_PATH/bin/zookeeper-server-start.sh  -daemon $KAFKA_PATH/config/zookeeper.properties
sleep 5
$KAFKA_PATH/bin/kafka-server-start.sh  -daemon $KAFKA_PATH/config/server.properties