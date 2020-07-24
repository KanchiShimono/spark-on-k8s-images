ARG base

FROM $base

ARG spark_uid=185

WORKDIR /opt/spark/work-dir
ENTRYPOINT [ "/opt/entrypoint.sh" ]

USER ${spark_uid}
