#!/bin/bash

export LANG=ko_KR.UTF-8
export LC_ALL=ko_KR.UTF-8

jenkins_war="/usr/share/java/jenkins.war"

count=$(ps -ef | grep "$jenkins_war" | grep -v grep | wc -l)

webhook_url="https://hooks.slack.com/services/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"

get_jenkins_status() {
    if [ "$count" -eq 0 ]; then
        echo "중지"
    else
        echo "실행 중"
    fi
}

timestamp=$(TZ='Asia/Seoul' date +'%Y년 %m월 %d일 %H시 %M분 %S초')

if [ "$count" -eq 0 ]; then
    systemctl restart jenkins
    action_message="젠킨스를 재시작합니다."
else
    action_message="젠킨스가 실행 중입니다."
fi

curl -X POST -H "Content-Type: application/json" -d "{
    \"text\": \"\",
    \"attachments\": [
        {
            \"color\": \"#36a64f\",
            \"pretext\": \"*제목: 젠킨스 상태 확인*\",
            \"fields\": [
                {
                    \"title\": \"상태\",
                    \"value\": \"$(get_jenkins_status)\",
                    \"short\": true
                },
                {
                    \"title\": \"시간\",
                    \"value\": \"$timestamp\",
                    \"short\": true
                },
                {
                    \"title\": \"메시지\",
                    \"value\": \"$action_message\",
                    \"short\": true
                }
            ]
        }
    ]
}" "$webhook_url"

