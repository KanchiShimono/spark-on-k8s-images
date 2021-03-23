ARG base_img

FROM $base_img

# https://github.com/apache/spark/blob/v3.0.0/resource-managers/kubernetes/docker/src/main/dockerfiles/spark/bindings/python/Dockerfile
WORKDIR /

USER 0

RUN mkdir ${SPARK_HOME}/python

# Copy python directory is all we need to multi stage build
COPY python/pyspark ${SPARK_HOME}/python/pyspark
COPY python/lib ${SPARK_HOME}/python/lib
