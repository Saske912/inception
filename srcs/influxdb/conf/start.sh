#!/bin/bash

service influxdb start && \
influx setup -u ${USER} -p ${ROOT_PASSWORD} -o ${USER} -b bucket -r 0 -t ${TOKEN} --name ${NAME} --force
service influxdb stop
influxd