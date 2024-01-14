#!/bin/bash

echo "30 3 * * *   root   sa-update && sa-compile &&\
  kill -HUP \`cat /var/run/spamd.pid\`" > /etc/cron.d/sa-update
cron


# Personnalisation de la configuration

#sed -i "s/#connect =/connect = host=${DB_HOST} dbname=${DB_DATABASE} user=${DB_USER} password=${DB_PASSWORD}/g" /etc/dovecot/dovecot-sql.conf.ext

#Start services

sa-update
sa-compile

spamd --username vmail \
      --nouser-config \
      --syslog stderr \
      --pidfile /var/run/spamd.pid \
      --helper-home-dir=/var/lib/spamassassin \
      --virtual-config-dir=/var/lib/spamassassin/%d/%l/.spamassassin \
      --ip-address \
      --create-prefs \
      --allowed-ips 0.0.0.0/0
