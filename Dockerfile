FROM ubuntu:latest

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update && apt install -y libplack-perl libdancer2-perl libapache2-mod-fcgid

WORKDIR /opt/pollenflug
COPY --chown=root:root . .
EXPOSE 3000

RUN chmod +x bin/pollenflug

ENTRYPOINT ["bin/pollenflug"]
