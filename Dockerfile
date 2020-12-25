FROM alpine:3.12 as builder

ARG ZT_COMMIT=e4404164bd9eb14c91906ec3cf577ba98eb24b8a

RUN apk add --update alpine-sdk linux-headers \
  && git clone --quiet https://github.com/zerotier/ZeroTierOne.git /src \
  && git -C src reset --quiet --hard ${ZT_COMMIT} \
  && cd /src \
  && make -f make-linux.mk

FROM alpine:edge
MAINTAINER  Senorsen <senorsen.zhang@gmail.com>

ENV VARNISH_CACHE malloc,100M
ENV VARNISH_CONFIG ""
ENV VARNISH_BACKEND_ADDRESS 192.168.1.65
ENV VARNISH_BACKEND_PORT 80
EXPOSE 80 9993/udp
VOLUME [ "/srv/varnish" ]


RUN apk add --update --no-cache libc6-compat libstdc++
COPY --from=builder /src/zerotier-one /usr/sbin/
RUN mkdir -p /var/lib/zerotier-one \
  && ln -s /usr/sbin/zerotier-one /usr/sbin/zerotier-idtool \
  && ln -s /usr/sbin/zerotier-one /usr/sbin/zerotier-cli
  
RUN apk update && \
    apk add varnish

ADD start.sh /start.sh
CMD [ "/start.sh && zerotier-one" ]
