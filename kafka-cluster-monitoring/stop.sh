#!/bin/bash

function stop() {
    docker-compose down
}

dirname=$(pwd)
kafka=$dirname/kafka-cluster
grafana=$dirname/grafana-monitoring-2

# 카프카 실행
cd $kafka
echo 'kafka 종료중입니다...'
stop

# 그라파나 실행
cd $grafana
echo 'grafana 종료중입니다...'
stop

#
cd $dirname

