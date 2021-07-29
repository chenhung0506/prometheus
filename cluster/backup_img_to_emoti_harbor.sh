#!/usr/bin/env bash

REPO=harbor.emotibot.com/bfop

stefanprodan/caddy

docker pull stefanprodan/caddy:latest 
docker tag stefanprodan/caddy:latest $REPO/caddy:v1.0.0
docker push $REPO/caddy:v1.0.0

docker pull google/cadvisor:latest
docker tag google/cadvisor:latest $REPO/cadvisor:v1.0.0
docker push $REPO/cadvisor:v1.0.0

docker pull grafana/grafana:5.3.4
docker tag grafana/grafana:5.3.4 $REPO/grafana:5.3.4
docker push $REPO/grafana:5.3.4

docker pull cloudflare/unsee:v0.8.0
docker tag cloudflare/unsee:v0.8.0 $REPO/unsee:v0.8.0
docker push $REPO/unsee:v0.8.0

docker pull stefanprodan/swarmprom-node-exporter:v0.16.0
docker tag stefanprodan/swarmprom-node-exporter:v0.16.0 $REPO/swarmprom-node-exporter:v0.16.0
docker push $REPO/swarmprom-node-exporter:v0.16.0

docker pull stefanprodan/swarmprom-prometheus:v2.5.0 
docker tag stefanprodan/swarmprom-prometheus:v2.5.0  $REPO/swarmprom-prometheus:v2.5.0
docker push $REPO/swarmprom-prometheus:v2.5.0