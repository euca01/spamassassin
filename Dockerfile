FROM alpine:3.18

ENV TZ=Europe/Paris

RUN apk add --no-cache bash spamassassin gpg-agent tzdata && \
       ln -s /usr/share/zoneinfo/$TZ /etc/localtime && \
       adduser -u 1000 -h /var/lib/spamassassin -D vmail vmail && \
       chown vmail:vmail /var/lib/spamassassin

COPY config/ /etc/spamassassin/

RUN ["chmod", "+x", "/etc/spamassassin/run.sh"]

CMD ["/etc/spamassassin/run.sh"]

EXPOSE 783
