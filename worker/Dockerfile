ARG base

FROM $base

ARG python_version=3.7.5

ENV PYENV_ROOT /opt/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

WORKDIR /

USER 0

RUN mkdir ${SPARK_HOME}/python

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
    liblzma-dev && \
  rm -rf /var/cache/apt/* && \
  rm -rf /var/lib/apt/lists/*

# Install Python via pyenv
RUN set -eux; \
  git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT} && \
  pyenv install $python_version && \
  pyenv global $python_version

# Install minimal python libraries for runnning pyspark
RUN set -eux; \
  pip install \
    numpy \
    pandas \
    pyarrow

COPY spark/python/pyspark ${SPARK_HOME}/python/pyspark
COPY spark/python/lib ${SPARK_HOME}/python/lib

#Install AWS-SDK
ARG HADOOP_AWS_JAR_VERSION=2.7.3
ARG AWS_JAVA_SDK_VERSION=1.7.4
RUN curl -o ${SPARK_HOME}/jars/hadoop-aws-${HADOOP_AWS_JAR_VERSION}.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_AWS_JAR_VERSION}/hadoop-aws-${HADOOP_AWS_JAR_VERSION}.jar && \
  curl -o ${SPARK_HOME}/jars/aws-java-sdk-${AWS_JAVA_SDK_VERSION}.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/${AWS_JAVA_SDK_VERSION}/aws-java-sdk-${AWS_JAVA_SDK_VERSION}.jar

WORKDIR /opt/spark/work-dir
ENTRYPOINT [ "/opt/entrypoint.sh" ]

ARG spark_uid=185
USER ${spark_uid}
