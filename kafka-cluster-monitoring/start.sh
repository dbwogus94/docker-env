#!/bin/bash

function run() {
    docker-compose down
    docker-compose up -d
}
dirname=$(pwd)
kafka=$dirname/kafka-cluster
grafana=$dirname/grafana-monitoring-2

# 카프카 실행
cd $kafka
echo '>>> [docker-compose] kafka-cluster 실행중입니다...'
run
# 10초 슬립
sleep 10s

# 그라파나 실행
cd $grafana
echo '>>> [docker-compose] grafana-monitoring 실행중입니다...'
run

cd $dirname

