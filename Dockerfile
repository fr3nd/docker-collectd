FROM debian:jessie
MAINTAINER Carles Amigó, fr3nd@fr3nd.net

ENV COLLECTD_VERSION e6553128adbed931c8ae36036d60e357868a9ec7

RUN apt-get update && apt-get install -y \
      autoconf \
      automake \
      autotools-dev \
      bison \
      build-essential \
      curl \
      flex \
      git \
      iptables-dev \
      libcurl4-gnutls-dev \
      libdbi0-dev \
      libesmtp-dev \
      libganglia1-dev \
      libgcrypt11-dev \
      libglib2.0-dev \
      libhiredis-dev \
      libltdl-dev \
      liblvm2-dev \
      libmemcached-dev \
      libmnl-dev \
      libmodbus-dev \
      libmysqlclient-dev \
      libopenipmi-dev \
      liboping-dev \
      libow-dev \
      libpcap-dev \
      libperl-dev \
      libpq-dev \
      libprotobuf-c-dev \
      librabbitmq-dev \
      librrd-dev \
      libsensors4-dev \
      libsnmp-dev \
      libtokyocabinet-dev \
      libtokyotyrant-dev \
      libtool \
      libupsclient-dev \
      libvirt-dev \
      libxml2-dev \
      libyajl-dev \
      linux-libc-dev \
      pkg-config \
      protobuf-c-compiler \
      python-dev

# Temporary packages
RUN apt-get -y install less vim

WORKDIR /usr/src
#RUN curl https://collectd.org/files/collectd-${COLLECTD_VERSION}.tar.bz2 | tar xvj
#WORKDIR /tmp/collectd-$COLLECTD_VERSION
RUN git clone https://github.com/collectd/collectd.git
WORKDIR /usr/src/collectd
RUN git checkout $COLLECTD_VERSION
RUN ./build.sh
RUN ./configure \
    --prefix=/usr \
    --sysconfdir=/etc/collectd \
    --without-libstatgrab \
    --without-included-ltdl \
    --disable-static
RUN make all
RUN make install
RUN make clean
ADD collectd.conf /etc/collectd/
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
