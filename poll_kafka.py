from kafka import KafkaConsumer
import argparse
import json
import time
states = {}

def parse_record(record):
    key = record.key.decode("utf-8")
    if "state" in key:
        track = key.replace("state:/", "")
        states[track] = json.loads(record.value.decode('utf-8'))


# ADD TREE PARSER




if __name__ == "__main__":
    # get time in ms
    start = time.time() * 1000

    parser = argparse.ArgumentParser(description="Process some integers.")
    parser.add_argument(dest="path")
    parser.add_argument("-topic", dest="topic", required=True)

    args = parser.parse_args()
    path = args.path
    topic = args.topic

    consumer = KafkaConsumer(topic)
    while not consumer._client.poll(): continue
    consumer.seek_to_beginning()

    last_time = -100000
    while last_time < start:
        message = consumer.poll()
        for topic_partition in message:
            for record in message[topic_partition]:
                last_time = record.timestamp
                if last_time < start:
                    parse_record(record)


    if path in states:
        print(states[path])

    else:
        print(f"Path not found in kafka partition {path}.")




