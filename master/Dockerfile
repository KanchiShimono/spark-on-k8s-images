ARG base

FROM $base

# TODO: change non root user
USER 0

COPY entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /spark/logs

RUN set -eux; \
  pip install \
    jupyterlab

WORKDIR /opt/spark/work-dir
ENTRYPOINT ["/opt/entry_point.sh"]
