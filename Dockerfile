FROM jenkins/jenkins:2.164-alpine

MAINTAINER Kevin Edwards "<kedwards@kevinedwards.ca>"

COPY data/executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

RUN /usr/local/bin/install-plugins.sh docker-plugin
