#!/usr/bin/env bash
if [ -z "$1" ]
then
  docker-compose up -d
fi

while getopts 's' OPT; do
    case $OPT in
        s) docker-compose down;;
    esac
done