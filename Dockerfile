FROM debian:jessie

ENV COLLECTD_VERSION 5.5.0
WORKDIR /usr/src/

ADD collectd.conf /etc/collectd/
ADD entrypoint.sh /entrypoint.sh

RUN apt-get update && \
    apt-get install -y build-essential wget tar lbzip2 && \
    wget https://collectd.org/files/collectd-$COLLECTD_VERSION.tar.bz2 && \
    tar xf collectd-$COLLECTD_VERSION.tar.bz2 && \
    cd collectd-$COLLECTD_VERSION && \
    ./configure && make && make install && \
    rm -rf /usr/src/collectd-$COLLECTD_VERSION* /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]
