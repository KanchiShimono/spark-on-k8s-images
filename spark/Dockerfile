ARG base

FROM $base

ARG spark_uid=185
ARG HADOOP_AWS_JAR_VERSION=3.2.0
ARG AWS_JAVA_SDK_VERSION=1.11.375

USER 0

# Install Python Build Tools
RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    sudo \
    git \
    wget \
    curl \
    less \
    iproute2 \
    procps && \
  rm -rf /var/cache/apt/* && \
  rm -rf /var/lib/apt/lists/*

# Install AWS-SDK
RUN curl -o ${SPARK_HOME}/jars/hadoop-aws-${HADOOP_AWS_JAR_VERSION}.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_AWS_JAR_VERSION}/hadoop-aws-${HADOOP_AWS_JAR_VERSION}.jar && \
  curl -o ${SPARK_HOME}/jars/aws-java-sdk-bundle-${AWS_JAVA_SDK_VERSION}.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_JAVA_SDK_VERSION}/aws-java-sdk-bundle-${AWS_JAVA_SDK_VERSION}.jar

# Add spark user if spark_uid is not root
RUN if [ ${spark_uid} != 0 ]; then \
    useradd -m -u ${spark_uid} spark; \
    # Change directory owner to spark running user
    # If did not change owner, access java.nio.file.AccessDeniedException will be occurred
    chown -R ${spark_uid}:${spark_uid} /opt/spark/work-dir; \
  fi

# For history server
COPY *-entrypoint.sh /opt/
RUN chmod +x /opt/*-entrypoint.sh

USER ${spark_uid}
