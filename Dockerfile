FROM debian:jessie

ENV COLLECTD_VERSION collectd-5.5.0
WORKDIR /usr/src/collectd

ADD collectd.conf /etc/collectd/
ADD entrypoint.sh /entrypoint.sh

RUN apt-get update && \
    apt-get install -y wget tar lbzip2 && \
    wget https://collectd.org/files/$COLLECTD_VERSION.tar.bz2 && \
    tar xf $COLLECTD_VERSION.tar.bz2 && \
    rm $COLLECTD_VERSION.tar.bz2 && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/src/collectd /usr/sbin/collectd && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
