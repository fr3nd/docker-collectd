#!/bin/bash

set -e

if [ -d /mnt/proc ]; then
  umount /proc
  mount -o bind /mnt/proc /proc
fi

if [ -z "$@" ]; then
  exec /usr/sbin/collectd -C /etc/collectd/collectd.conf -f
else
  exec $@
fi
