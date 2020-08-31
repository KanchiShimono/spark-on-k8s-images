ARG base

FROM $base

ARG spark_uid=185

WORKDIR /opt/spark/work-dir

USER ${spark_uid}

ENTRYPOINT [ "/opt/entrypoint.sh" ]
