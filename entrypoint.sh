#!/bin/sh
if [ ! -f /data/config.yaml ]; then
  cp /data/config.yaml.default /data/config.yaml
fi
exec /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
