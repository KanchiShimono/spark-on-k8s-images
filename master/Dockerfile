ARG base

FROM $base

COPY entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_MASTER_LOG /spark/logs

# Install Mecab
RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    file \
    mecab \
    libmecab-dev \
    mecab-ipadic-utf8 && \
  rm -rf /var/lib/apt/lists/*

# Install neologd the dictionary for Mecab
RUN set -eux; \
  git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git /tmp/mecab-ipadic-neologd && \
  /tmp/mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y && \
  rm -rf /tmp/mecab-ipadic-neologd

RUN set -eux; \
  pip install \
    numpy \
    pandas \
    pyarrow \
    mecab-python3 \
    jupyterlab

ENTRYPOINT ["/opt/entry_point.sh"]
