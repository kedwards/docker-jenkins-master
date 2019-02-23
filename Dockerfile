FROM jenkins/jenkins:2.165-alpine

MAINTAINER Kevin Edwards "<kedwards@kevinedwards.ca>"

COPY data/executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

RUN /usr/local/bin/install-plugins.sh docker-plugin \
  ant \
  build-timeout \
  email-ext \
  github-branch-source \
  gradle \
  antisamy-markup-formatter \
  workflow-aggregator \
  timestamper \
  amazon-ecs \
  ec2 \
  scalable-amazon-ecs \
  checkstyle \
  cloverphp \
  crap4j \
  dry \
  htmlpublisher \
  jdepend \
  plot \
  pmd \
  violations \
  warnings \
  xunit \
  git \
  build-monitor-plugin 
