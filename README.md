# phoebus-demo

## Set up

1. Download Kafka [here](https://www.apache.org/dyn/closer.cgi?path=/kafka/2.7.0/kafka_2.13-2.7.0.tgz) and unzip the file. 
2. Open two terminal windows and navigate into the kafka directory in each.  
3. In first terminal, start zookeeper:   
``` $ bin/zookeeper-server-start.sh config/zookeeper.properties ```  
4. In the second terminal, start Kafka. Kafka must be started after zookeeper.  
``` $ bin/kafka-server-start.sh config/server.properties ```  
5. Download the Phoebus repository:  
``` $ git clone https://github.com/ControlSystemStudio/phoebus.git```  
6. Navigate into the Phoebus alarm server directory  
``` $ cd phoebus/services/alarm-server ```  
7. Build the alarm server with maven (OpenJDK>11, maven>=2, I use OpenJDK =11, maven=3.6.3)  
``` $ mvn clean install```  
8. Now, need to create Kafka topics associated with your configuration. A utility script is provided in this repository. Set the environment variable `KAFKA_PATH` to your installation path. Then, execute the topic creation:  
``` $ scripts/start_alarm_server.sh Demo ```  
9. Load configuration for Demo into the alarm server. You can start the alarm server directly from the phoebus alarm server directory or using the  `start_alarm_server.sh` script given here:  
``` $ scripts/start_alarm_server.sh -config Demo -import demo.xml -logging logging.properties```   
10. Start the alarm server  
``` $ scripts/start_alarm_server.sh -settings demo_settings.ini -logging logging.properties ```  
11. Start the demo ioc  
``` $ softIoc -d demo.db ```  


