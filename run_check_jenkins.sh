#!/bin/bash

count=$(ps -ef | grep /usr/share/java/jenkins.war | grep -v grep | wc -l)
webhook_url="https://hooks.slack.com/services/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"

if [ "$count" -eq 0 ]; then
    systemctl restart jenkins
    message="Jenkins restarted."
else
    message="Jenkins is already running."
fi

curl -X POST -H "Content-Type: application/json" -d "{\"text\":\"$message\"}" "$webhook_url"
