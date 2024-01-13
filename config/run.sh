#!/bin/bash

echo "30 3 * * *   root   sa-update &&\
  kill -HUP \`cat /var/run/spamd.pid\`" > /etc/cron.d/sa-update
cron


# Personnalisation de la configuration

#sed -i "s/#connect =/connect = host=${DB_HOST} dbname=${DB_DATABASE} user=${DB_USER} password=${DB_PASSWORD}/g" /etc/dovecot/dovecot-sql.conf.ext

#Start services

sa-update

spamd --username vmail \
      --nouser-config \
      --syslog stderr \
      --pidfile /var/run/spamd.pid \
      --helper-home-dir /var/lib/spamassassin \
      --ip-address \
      --allowed-ips 0.0.0.0/0
