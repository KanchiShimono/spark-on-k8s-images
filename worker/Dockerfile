FROM kanchishimono/spark-base:latest

COPY entry_point.sh /

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /spark/logs

RUN set -eux; \
  pip install \
    numpy \
    pandas \
    pyarrow

CMD ["/bin/bash", "/entry_point.sh"]
