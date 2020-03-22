#!/bin/bash

. "/spark/sbin/spark-config.sh"
. "/spark/bin/load-spark-env.sh"

export PYTHONPATH=$PYTHONPATH:/spark/python:/spark/python/lib/py4j-0.10.7-src.zip
export PYSPARK_PYTHON=/root/.pyenv/shims/python3
export PYSPARK_DRIVER_PYTHON=/root/.pyenv/shims/python3

mkdir -p $SPARK_MASTER_LOG
ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

WORKDIR=/home/work/
mkdir -p ${WORKDIR}
cd ${WORKDIR}
jupyter lab --ip=0.0.0.0 --no-browser --allow-root
