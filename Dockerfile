FROM alpine:latest

COPY --chown=root:root . ~/opt/pollenflug/
EXPOSE 3000
ENTRYPOINT ["/opt/pollenflug/bin/pollenflug"]
