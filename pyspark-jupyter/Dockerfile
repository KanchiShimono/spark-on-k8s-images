ARG base

FROM $base

ARG spark_uid=185

USER 0

COPY jupyter-entrypoint.sh /opt/
RUN chmod +x /opt/jupyter-entrypoint.sh

ENV PYTHONPATH $PYTHONPATH:/opt/spark/python:/opt/spark/python/lib/py4j-0.10.9-src.zip
ENV PYSPARK_PYTHON $PYENV_ROOT/shims/python3
ENV PYSPARK_DRIVER_PYTHON $PYENV_ROOT/shims/python3

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /spark/logs

COPY requirements.txt /opt/requirements.txt
RUN set -eux; \
  pip install -r /opt/requirements.txt && \
  rm /opt/requirements.txt

RUN mkdir -p $SPARK_MASTER_LOG && \
  ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

USER ${spark_uid}

ENTRYPOINT ["/opt/jupyter-entrypoint.sh"]
