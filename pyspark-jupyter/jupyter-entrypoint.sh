#!/bin/bash

WORKDIR=/home/spark/work
mkdir -p ${WORKDIR}
cd ${WORKDIR}

exec jupyter lab
