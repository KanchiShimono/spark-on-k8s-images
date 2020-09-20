#!/bin/bash

WORKDIR=/home/spark/work
mkdir -p ${WORKDIR}
cd ${WORKDIR}

if [[ ! -z "${JUPYTER_TOKEN}" ]]; then
    echo "c.NotebookApp.token = '${JUPYTER_TOKEN}'" >> /etc/jupyter/jupyter_notebook_config.py
fi

exec jupyter lab
