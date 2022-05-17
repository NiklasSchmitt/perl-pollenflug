FROM perl:5.34.1-slim-buster

RUN apt update && apt install -y libplack-perl libdancer2-perl libjson-perl unzip

ADD https://github.com/NiklasSchmitt/perl-pollenflug/archive/refs/heads/master.zip /tmp
RUN unzip /tmp/master.zip -d /opt && mv /opt/perl-pollenflug-master /opt/pollenflug
RUN chmod +x /opt/pollenflug/bin/pollenflug && rm /tmp/master.zip && apt-get -y autoremove && apt-get clean

EXPOSE 3000/tcp

ENTRYPOINT ["/opt/pollenflug/bin/pollenflug"]
