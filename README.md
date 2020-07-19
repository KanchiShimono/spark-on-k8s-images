# spark-on-k8s-images

Docker images for spark on kubernetes

| Name           | Description                                                                                                                                                     |
| :------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| base           | Base image for spark master and spark history server. Worker does not use this base image. Python is not installed yet.                                         |
| history-server | Spark history server                                                                                                                                            |
| master         | Spark master                                                                                                                                                    |
| worker         | Spark worker. The base image is build by spark official tool tool [docker-image-tool.sh](https://github.com/apache/spark/blob/master/bin/docker-image-tool.sh). |
