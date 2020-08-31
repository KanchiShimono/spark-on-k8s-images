ARG base

FROM $base

ARG spark_uid=185

USER 0

COPY entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh

# Add spark user
# No name user causes "Exception: invalid null input: name"
# when starting history server
RUN useradd -m -u ${spark_uid} spark

ENTRYPOINT ["/opt/entry_point.sh"]

USER ${spark_uid}
