ARG base

FROM $base

COPY entry_point.sh /opt/

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /spark/logs

RUN set -eux; \
  pip install \
    numpy \
    pandas \
    pyarrow \
    jupyterlab

ENTRYPOINT ["/opt/entry_point.sh"]
