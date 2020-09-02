ARG base

FROM $base

ARG spark_uid=185

USER 0

COPY entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh

# Add spark user if spark_uid is not root.
# No name user causes "Exception: invalid null input: name" when starting history server.
# The base image of this is assumed plain spark image (not installed pyspark) build by official tool,
# so user spark has not created yet here.
RUN if [ ${spark_uid} != 0 ]; then \
    useradd -m -u ${spark_uid} spark; \
  fi

USER ${spark_uid}

ENTRYPOINT ["/opt/entry_point.sh"]
