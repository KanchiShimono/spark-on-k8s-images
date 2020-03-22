#!/bin/bash

. "/spark/sbin/spark-config.sh"
. "/spark/bin/load-spark-env.sh"

export PYTHONPATH=$PYTHONPATH:/spark/python:/spark/python/lib/py4j-0.10.7-src.zip

mkdir -p $SPARK_WORKER_LOG
ln -sf /dev/stdout $SPARK_WORKER_LOG/spark-worker.out
