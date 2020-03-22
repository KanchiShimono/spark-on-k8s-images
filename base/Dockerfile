FROM openjdk:8-jre-slim

ARG python_version=3.7.5
ARG SPARK_VERSION=2.4.5
ARG HADOOP_VERSION=2.7

ENV SPARK_HOME=/opt/spark
ENV PYENV_ROOT /opt/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Install Build Tools
RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    sudo \
    git \
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
    liblzma-dev && \
  wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
  tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
  mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME} && \
  rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
  rm -rf /var/lib/apt/lists/*

# Install Python
RUN set -eux; \
  git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT} && \
  pyenv install $python_version && \
  pyenv global $python_version
