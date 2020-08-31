ARG base

FROM $base

ARG spark_uid=185

USER 0

COPY entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /spark/logs

COPY requirements.txt /opt/requirements.txt
RUN set -eux; \
  pip install -r /opt/requirements.txt && \
  rm /opt/requirements.txt

WORKDIR /opt/spark/work-dir
ENTRYPOINT ["/opt/entry_point.sh"]

USER ${spark_uid}
