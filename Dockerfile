FROM alpine:edge
MAINTAINER  Senorsen <senorsen.zhang@gmail.com>

ENV VARNISH_CACHE malloc,100M
ENV VARNISH_CONFIG ""
ENV VARNISH_BACKEND_ADDRESS 192.168.1.65
ENV VARNISH_BACKEND_PORT 80
EXPOSE 80
VOLUME [ "/etc/varnish", "/srv/varnish" ]

RUN apk update && \
    apk upgrade && \
    apk add varnish

ADD start.sh /start.sh
RUN chmod +x /start.sh
CMD [ "/start.sh" ]
