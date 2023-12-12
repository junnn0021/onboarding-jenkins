#!/bin/bash
docker build -t jenkins .

docker run -d -p 80:8080 --privileged --name js-jenkins jenkins

sleep 20

docker exec -it js-jenkins cat /var/lib/jenkins/secrets/initialAdminPassword
