#!/bin/bash -eu
AWS_JAVA_SDK_VERSION=1.11.375
HADOOP_VERSION=3.2
HADOOP_AWS_JAR_VERSION=3.2.0
PYTHON_VERSION=3.8.5
IMAGE_OWNER=kanchishimono
SPARK_UID=1850
SPARK_VERSION=3.0.0
TAG=master

PS3="What do you build? (Enter 'a' for build all) > "
select TARGET in base-spark spark pyspark pyspark-jupyter
do
  # Downlaod Spark
  if [ ! -e origin-spark ]; then
    (
      wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
      tar xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
      mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} origin-spark
    )
  fi

  if [ "$TARGET" = "base-spark" ] || [ "$REPLY" = "a" ]; then
    # Build original Spark Docker image
    (
      cp -rp origin-spark base-spark/ && \
      cd base-spark && \
      origin-spark/bin/docker-image-tool.sh \
        -r spark \
        -t ${TAG} \
        -f Dockerfile \
        -p bindings/python/Dockerfile \
        -u ${SPARK_UID} \
        build
    )
  fi

  if [ "$TARGET" = "spark" ] || [ "$REPLY" = "a" ]; then
    # Build custom Spark Docker image
    (
      cd spark && \
      docker build \
        -t ${IMAGE_OWNER}/spark:${TAG} \
        --build-arg base=spark/spark:${TAG} \
        --build-arg spark_uid=${SPARK_UID} \
        --build-arg HADOOP_AWS_JAR_VERSION=${HADOOP_AWS_JAR_VERSION} \
        --build-arg AWS_JAVA_SDK_VERSION=${AWS_JAVA_SDK_VERSION} \
        .
    )
  fi

  if [ "$TARGET" = "pyspark" ] || [ "$REPLY" = "a" ]; then
    # Build PySpark Docker image
    (
      cd pyspark && \
      docker build \
        -t ${IMAGE_OWNER}/pyspark:${TAG} \
        --build-arg base=${IMAGE_OWNER}/spark:${TAG} \
        --build-arg base_pyspark=spark/spark-py:${TAG} \
        --build-arg spark_uid=${SPARK_UID} \
        --build-arg PYTHON_VERSION=${PYTHON_VERSION} \
        .
    )
  fi

  if [ "$TARGET" = "pyspark-jupyter" ] || [ "$REPLY" = "a" ]; then
    # Build PySpark with Jupyter Docker image
    (
      cd pyspark-jupyter && \
      docker build \
        -t ${IMAGE_OWNER}/pyspark-jupyter:${TAG} \
        --build-arg base=${IMAGE_OWNER}/pyspark:${TAG} \
        --build-arg spark_uid=${SPARK_UID} \
        .
    )
  fi

  echo ""
  docker images | grep "${IMAGE_OWNER}" | grep ${TAG} | sort
  break
done
