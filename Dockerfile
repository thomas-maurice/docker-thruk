FROM debian:jessie

EXPOSE 80

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        wget \
        apache2 \
        libexpat1 \
        libgd3 \
        libmysqlclient18 \
        libapache2-mod-fcgid \
        nginx-full \
        cron \
        apache2-utils \
        logrotate

RUN wget http://download.thruk.org/pkg/v2.10/debian8/amd64/libthruk_2.10-1_debian8_amd64.deb && \
    wget http://download.thruk.org/pkg/v2.10/debian8/amd64/thruk-base_2.10_debian8_amd64.deb && \
    wget http://download.thruk.org/pkg/v2.10/debian8/amd64/thruk_2.10_debian8_amd64.deb && \
    dpkg -i libthruk_2.10-1_debian8_amd64.deb && \
    dpkg -i thruk-base_2.10_debian8_amd64.deb && \
    dpkg -i thruk_2.10_debian8_amd64.deb

COPY thruk.conf /etc/thruk/thruk.conf
# So that we can have logs on stdout
# still not quite ok with apache logs tho
COPY log4perl.conf /etc/thruk/log4perl.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
