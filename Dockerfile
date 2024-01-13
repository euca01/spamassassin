FROM debian:bookworm-slim


ENV TZ=UTC


RUN apt-get -yq update && apt-get -y upgrade && \
    apt-get install -y ca-certificates cron curl libmail-dkim-perl libnet-ident-perl gpg gpg-agent spamd spamassassin && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/log/* && \
    useradd -u 1000 -d /var/lib/spamassassin vmail && \
    chown -R vmail /var/lib/spamassassin

COPY config/run.sh /run.sh
RUN chmod +x /run.sh
VOLUME ["/var/lib/spamassassin", "/var/log"]
EXPOSE 783
ENTRYPOINT ["/run.sh"]
