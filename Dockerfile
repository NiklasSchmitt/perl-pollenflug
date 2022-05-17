FROM ubuntu:latest

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update && apt install -y perl libplack-perl libdancer2-perl unzip

# first bad solution: just copy from here into container
#COPY --chown=root:root . .

# second bad solution: download .zip from github and move around the container
ADD https://github.com/NiklasSchmitt/perl-pollenflug/archive/refs/heads/master.zip /tmp
RUN unzip /tmp/master.zip -d /opt && mv /opt/perl-pollenflug-master /opt/pollenflug
RUN chmod +x /opt/pollenflug/bin/pollenflug && rm /tmp/master.zip

EXPOSE 3000

ENTRYPOINT ["/opt/pollenflug/bin/pollenflug"]
