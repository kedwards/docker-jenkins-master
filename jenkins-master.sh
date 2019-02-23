#!/usr/bin/env bash
set -Eeuo pipefail

docker container run --rm -idt --name jenkins-master --env JAVA_OPTS=-Dhudson.footerURL=http://kevinedwards.ca --p 8080:8080
-v /vagrant/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock kevinedwards/jenkins-master:latest "$@"
