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

# Add spark user
RUN useradd -m -u ${spark_uid} spark 

RUN mkdir -p $SPARK_MASTER_LOG && \
  ln -sf /dev/stdout $SPARK_MASTER_LOG/spark-master.out

WORKDIR /opt/spark/work-dir

USER ${spark_uid}

ENTRYPOINT ["/opt/entry_point.sh"]
