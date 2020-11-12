#!/bin/bash

WORKDIR=/home/spark
mkdir -p ${WORKDIR}
cd ${WORKDIR}

exec jupyter lab
