ARG base

FROM $base

ARG spark_uid=185

USER 0

COPY entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh

ENTRYPOINT ["/opt/entry_point.sh"]

USER ${spark_uid}
