ARG base

FROM $base

ARG python_version=3.7.5
ARG spark_uid=185
ARG HADOOP_AWS_JAR_VERSION=2.7.3
ARG AWS_JAVA_SDK_VERSION=1.7.4

ENV PYENV_ROOT /opt/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

WORKDIR /

USER 0

# Install Python Build Tools
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
    liblzma-dev \
    file \
    mecab \
    libmecab-dev \
    mecab-ipadic-utf8 \
    procps && \
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
  pip install -r /opt/requirements.txt && \
  rm /opt/requirements.txt

RUN mkdir ${SPARK_HOME}/python
COPY spark/python/pyspark ${SPARK_HOME}/python/pyspark
COPY spark/python/lib ${SPARK_HOME}/python/lib

# Install AWS-SDK
RUN curl -o ${SPARK_HOME}/jars/hadoop-aws-${HADOOP_AWS_JAR_VERSION}.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_AWS_JAR_VERSION}/hadoop-aws-${HADOOP_AWS_JAR_VERSION}.jar && \
  curl -o ${SPARK_HOME}/jars/aws-java-sdk-bundle-${AWS_JAVA_SDK_VERSION}.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_JAVA_SDK_VERSION}/aws-java-sdk-bundle-${AWS_JAVA_SDK_VERSION}.jar

# Add spark user if spark_uid is not root
# No name user causes "Exception: invalid null input: name" when starting history server
RUN if [ ${spark_uid} != 0 ]; then \
    useradd -m -u ${spark_uid} spark \
  fi

# Change directory owner to spark running user
# If did not change owner, access java.nio.file.AccessDeniedException will be occurred
RUN chown -R ${spark_uid}:${spark_uid} /opt/spark/work-dir

WORKDIR /opt/spark/work-dir
USER ${spark_uid}
