#!/bin/sh

usage()
{
cat << EOF
usage: bash ./scripts/start_services.sh -logging logging_file -config config_name -settings settings_file -config-file config_file
-logging           (Required)                    Logging configuration file
-config            (Required)                    Configuration name
-settings          (Required)                    Settings file
-create-topics     (Optional)                    Indicates topic creation necessary
EOF
}

while [ "$1" != "" ]; do
    case $1 in
        -logging)
            shift
            logging_file=$1
        ;;
        -config)
            shift
            config=$1
        ;;
        -settings)
            shift
            settings=$1
        ;;
        -create-topics)
            create_topics=1  
        ;;
        -config-file)
            shift
            config_file=$1
        ;;      
        -h | --help )    usage
            exit
        ;;
        * )              usage
            exit 1
    esac
    shift
done


$KAFKA_PATH/bin/zookeeper-server-start.sh  -daemon $KAFKA_PATH/config/zookeeper.properties
sleep 30
$KAFKA_PATH/bin/kafka-server-start.sh  -daemon server.properties

#start elastic search
$ELASTICSEARCH_PATH/bin/elasticsearch -d

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# create topics?
if [[ "$create_topics" == 1 ]]; then
    bash $DIR/create_topics.sh $config
    bash $ALARM_LOGGER_PATH/startup/create_alarm_template.sh -topic $config
fi


# remove log files
rm logs/alarm_server.out
rm logs/alarm_logger.out


# import config file
nohup bash $DIR/start_alarm_server.sh -config $config -import $config_file -logging $logging_file 0<&- &> logs/alarm_server.out &

sleep 10

nohup bash $DIR/start_alarm_server.sh -logging $logging_file -settings $settings -noshell 0<&- &> logs/alarm_server.out &


# start alarm  logger
nohup bash $DIR/start_alarm_logger.sh -topics $config -logging $logging_file -noshell <&- &> logs/alarm_logger.out &


# start alarm config logger
#nohup bash $DIR/start_alarm_config_logger.sh -topics $config 0<&- &> alarm_config_logger.out &
