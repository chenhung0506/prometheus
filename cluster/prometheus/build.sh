#!/bin/bash
TAG=$(git rev-parse --short=7 HEAD)-$(git log HEAD -n1 --pretty='format:%cd' --date=format:'%Y%m%d-%H%M')
# TAG=latest
docker build -t harbor.emotibot.com/bfop/prometheus:$TAG -f Dockerfile . --no-cache
echo "harbor.emotibot.com/bfop/prometheus:$TAG"

docker push harbor.emotibot.com/bfop/prometheus:$TAG