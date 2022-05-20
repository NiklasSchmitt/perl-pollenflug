FROM ubuntu:latest

RUN apt update && apt install -y libplack-perl libdancer2-perl libjson-perl unzip apache2 libapache2-mod-fcgid

ADD https://github.com/NiklasSchmitt/perl-pollenflug/archive/refs/heads/master.zip /tmp
RUN unzip /tmp/master.zip -d /opt && mv /opt/perl-pollenflug-master /opt/pollenflug && chmod +x /opt/pollenflug/bin/pollenflug && rm /tmp/master.zip && apt-get -y autoremove && apt-get clean


RUN mv /opt/pollenflug/vhost-pollenflug.conf /etc/apache2/sites-available/pollenflug.conf && mkdir /var/log/apache2/pollenflug && chmod +x /opt/pollenflug/public/dispatch.fcgi && a2enmod rewrite && a2dissite 000-default.conf && a2ensite pollenflug && service apache2 restart


EXPOSE 80/tcp

#ENTRYPOINT ["/opt/pollenflug/bin/pollenflug"]
ENTRYPOINT ["/bin/bash"]
