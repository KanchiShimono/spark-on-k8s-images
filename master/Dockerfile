ARG base

FROM $base

COPY entry_point.sh /

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /spark/logs

RUN set -eux; \
  pip install \
    numpy \
    pandas \
    pyarrow \
    jupyterlab

CMD ["/bin/bash", "/entry_point.sh"]
