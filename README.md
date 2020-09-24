# spark-on-k8s-images

[![GitHub Actions status](https://github.com/KanchiShimono/spark-on-k8s-images/workflows/Build/badge.svg)](https://github.com/KanchiShimono/spark-on-k8s-images/actions?query=workflow%3ABuild)

Docker images for spark on kubernetes

| Name            | Description                                                                                                                                                                           |
| :-------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| spark           | Spark image for Spark on k8s. This image built on the image that built by official tool [docker-image-tool.sh](https://github.com/apache/spark/blob/master/bin/docker-image-tool.sh). |
| pyspark         | PySpark image for Spark on k8s. Install PySpark on Spark image.                                                                                                                       |
| pyspark-jupyter | Install Jupyter Lab Server on PySpark image.                                                                                                                                          |
