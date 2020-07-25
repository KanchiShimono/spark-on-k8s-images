ARG base

FROM $base

# TODO: change non root user
USER 0

COPY entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh

ENTRYPOINT ["/opt/entry_point.sh"]
