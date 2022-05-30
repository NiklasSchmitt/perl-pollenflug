FROM ubuntu:latest

RUN apt update && apt install -y apache2 libapache2-mod-fcgid

COPY vhost-pollenflug.conf /etc/apache2/sites-available/pollenflug.conf

RUN mkdir /var/log/apache2/pollenflug && a2enmod proxy && a2enmod proxy_fcgi && a2dissite 000-default.conf && a2ensite pollenflug

EXPOSE 80/tcp

CMD apachectl -D FOREGROUND
