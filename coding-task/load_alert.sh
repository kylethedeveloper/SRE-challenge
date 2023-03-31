#!/bin/bash
# set -x # For debugging

# URL to check load time, include HTTP or HTTPS protocol for accurate result.
WEBSITE="https://namecheap.com"

# Threshold in seconds. Beyond this value, alert is sent. Value can include decimals.
THRESHOLD="0.5"

# Slack variables
CHANNEL_ID="C123456" # Channel, private group, or IM channel to send message to
TOKEN="xoxb-not-a-real-token-this-will-not-work" # Authentication token that has chat.postMessage scope

# Saving load time in a variable
load_time=$(curl -s -o /dev/null -w "%{time_total}\n" $WEBSITE)

# Function to send a message to the Slack channel.
slack_alert() {
    message="${1:-"ALERT! Load time is beyond threshold."}"
    echo "curl -d \"text=$message\" \
        -d \"channel=$CHANNEL_ID\" \
        -H \"Authorization: Bearer $TOKEN\" \
        -X POST https://slack.com/api/chat.postMessage"
    exit 1
}

# If load time is greater than threshold, alert; else, exit.
if (( $(echo "$load_time $THRESHOLD" | awk '{print ($1 > $2)}') )) ; then
    message="ALERT! Load time for $WEBSITE is $load_time and beyond threshold: $THRESHOLD"
    slack_alert "$message"
else
    echo "OK"
    exit 0
fi
