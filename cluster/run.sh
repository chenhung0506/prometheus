#!/usr/bin/env bash
# docker service rm $(docker service ls -q)
# docker config rm $(docker config ls -q)

if [ -z "$1" ]
then
  ADMIN_USER=admin \
  ADMIN_PASSWORD=admin \
  SLACK_URL=https://hooks.slack.com/services/TOKEN \
  SLACK_CHANNEL=devops-alerts \
  SLACK_USER=alertmanager \
  docker stack deploy -c docker-compose.yml mon
fi

while getopts 's' OPT; do
    case $OPT in
        s) docker stack rm mon;;
    esac
done
