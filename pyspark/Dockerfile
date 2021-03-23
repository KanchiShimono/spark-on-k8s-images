ARG base
ARG base_pyspark

FROM ${base_pyspark} as base-pyspark

FROM $base

ARG python_version=3.8.5
ARG spark_uid=185

ENV PYENV_ROOT /opt/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

USER 0

# Install Python Build Tools
RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    make \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    file \
    mecab \
    libmecab-dev \
    mecab-ipadic-utf8 && \
  rm -rf /var/cache/apt/* && \
  rm -rf /var/lib/apt/lists/*

# Install neologd the dictionary for Mecab
RUN set -eux; \
  git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git /tmp/mecab-ipadic-neologd && \
  /tmp/mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n -y && \
  rm -rf /tmp/mecab-ipadic-neologd

# Install Python via pyenv
RUN set -eux; \
  git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT} && \
  pyenv install $python_version && \
  pyenv global $python_version

# Install python libraries for runnning pyspark
COPY requirements.txt /opt/requirements.txt
RUN set -eux; \
  pip install --no-cache-dir -r /opt/requirements.txt && \
  rm /opt/requirements.txt

RUN mkdir ${SPARK_HOME}/python
COPY --from=base-pyspark ${SPARK_HOME}/python/pyspark ${SPARK_HOME}/python/pyspark
COPY --from=base-pyspark ${SPARK_HOME}/python/lib ${SPARK_HOME}/python/lib

USER ${spark_uid}
