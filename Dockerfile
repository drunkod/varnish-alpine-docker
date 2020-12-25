
FROM zyclonite/zerotier:latest
￼
ENV VARNISH_CACHE malloc,100M
ENV VARNISH_CONFIG ""
ENV VARNISH_BACKEND_ADDRESS 192.168.1.65
ENV VARNISH_BACKEND_PORT 80
EXPOSE 80 9993/udp
VOLUME [ "/srv/varnish" ]

RUN apk update && \
    apk add varnish

ADD start.sh /start.sh

CMD [ "/start.sh" ]
