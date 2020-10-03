#!/bin/bash

if [[ -z "${EVENT_LOG_DIR}" ]]; then
    # Default event log directory
    EVENT_LOG_DIR="file:/tmp/spark-events"
fi
if [[ "${EVENT_LOG_DIR}" =~ ^file: ]] && [[ ! -e "${EVENT_LOG_DIR#file:}" ]]; then
    # Create directory, if specified local directory (starts with file:) and path not exists
    mkdir -p "${EVENT_LOG_DIR#file:}"
fi

export SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory='${EVENT_LOG_DIR}'"

exec /opt/spark/bin/spark-class org.apache.spark.deploy.history.HistoryServer
