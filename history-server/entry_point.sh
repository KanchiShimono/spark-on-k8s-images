#!/bin/bash

if [[ -z "${EVENT_LOG_DIR}" ]]; then
    # Default event log directory
    EVENT_LOG_DIR="file:///tmp/spark-events"
fi
if [[ ! -d "${EVENT_LOG_DIR}" ]]; then
    mkdir -p "${EVENT_LOG_DIR}"
fi

export SPARK_HISTORY_OPTS="-Dspark.history.fs.logDirectory='${EVENT_LOG_DIR}'"

exec /opt/spark/bin/spark-class org.apache.spark.deploy.history.HistoryServer
