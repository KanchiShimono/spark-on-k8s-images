#!/bin/bash

export PYTHONPATH=$PYTHONPATH:/opt/spark/python:/opt/spark/python/lib
export PYSPARK_PYTHON=${PYENV_ROOT}/shims/python3
export PYSPARK_DRIVER_PYTHON=${PYENV_ROOT}/shims/python3

mkdir -p $SPARK_MASTER_LOG
ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

WORKDIR=/home/work/
mkdir -p ${WORKDIR}
cd ${WORKDIR}
if [[ ! -z "${JUPYTER_TOKEN}" ]]; then
    tokenOpt="--NotebookApp.token='${JUPYTER_TOKEN}'"
fi
exec jupyter lab --ip=0.0.0.0 --no-browser --allow-root $tokenOpt

