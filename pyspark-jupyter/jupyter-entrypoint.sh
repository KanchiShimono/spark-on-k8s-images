#!/bin/bash

WORKDIR=/home/spark/work
mkdir -p ${WORKDIR}
cd ${WORKDIR}

jupyter lab --generate-config

cat << EOF >> ${HOME}/.jupyter/jupyter_notebook_config.py
c.NotebookApp.terminado_settings = { 'shell_command': ['/bin/bash'] }
EOF

if [[ ! -z "${JUPYTER_TOKEN}" ]]; then
    echo "c.NotebookApp.token = ${JUPYTER_TOKEN}" >> ${HOME}/.jupyter/jupyter_notebook_config.py
fi

exec jupyter lab --ip=0.0.0.0 --no-browser
