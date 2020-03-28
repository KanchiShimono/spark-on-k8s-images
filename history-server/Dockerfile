ARG base

FROM $base

COPY entry_point.sh /opt/
RUN chmod +x /opt/entry_point.sh

ENTRYPOINT ["/opt/entry_point.sh"]
