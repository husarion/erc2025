#!/bin/bash

# Exit if no arguments are provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <topic_name1> <topic_name2> ... <topic_nameN>"
    echo "or (for all visible topics):"
    echo "ros2 topic list | xargs $0 > filter.yaml"
    exit 1
fi

echo "allowlist:"
echo "  - name: \"rt/*\""
echo "blocklist: []"
echo "topics:"
echo "  - name: \"rt/chatter\""
echo "    qos:"
echo "      reliability: true"
echo "      durability: true"
echo "builtin-topics:"

# Loop over each topic provided as argument
for TOPIC in "$@"; do
    # Fetch details using 'ros2 topic info'
    INFO=$(ros2 topic info -v $TOPIC)

    # Extract type of the message
    TYPE=$(echo "$INFO" | grep "Type:" | awk '{print $2}')

    # Convert ROS2 message type to DDS type dynamically
    PACKAGE_NAME=$(echo $TYPE | cut -d'/' -f1)
    MSG_NAME=$(echo $TYPE | cut -d'/' -f3)

    # Construct DDS_TYPE using the parsed package and message names
    DDS_TYPE="${PACKAGE_NAME}::msg::dds_::${MSG_NAME}_"

    # Check if conversion is successful
    if [ -z "$DDS_TYPE" ]; then
        echo "Error during type conversion for topic $TOPIC."
        continue
    fi

    # Print entry for current topic with QoS settings
    echo "  - name: \"rt$TOPIC\""
    echo "    type: \"$DDS_TYPE\""
done

