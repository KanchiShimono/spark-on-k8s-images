#!/bin/bash

export PYTHONPATH=$PYTHONPATH:/opt/spark/python:/opt/spark/python/lib/py4j-0.10.9-src.zip
export PYSPARK_PYTHON=${PYENV_ROOT}/shims/python3
export PYSPARK_DRIVER_PYTHON=${PYENV_ROOT}/shims/python3

WORKDIR=/home/spark/work
mkdir -p ${WORKDIR}
cd ${WORKDIR}
if [[ ! -z "${JUPYTER_TOKEN}" ]]; then
    tokenOpt="--NotebookApp.token='${JUPYTER_TOKEN}'"
fi
exec jupyter lab --ip=0.0.0.0 --no-browser $tokenOpt
