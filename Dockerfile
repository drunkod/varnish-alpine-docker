FROM bltavares/zerotier:latest
LABEL version="1.6.2"
LABEL description="ZeroTier One + Varnish as Docker Image"
ENV VARNISH_BACKEND_ADDRESS 192.168.1.65
ENV VARNISH_MEMORY 100M
ENV VARNISH_BACKEND_PORT 80
EXPOSE 80

EXPOSE 9993/udp
  
RUN apk update && \
    apk upgrade && \
    apk add varnish
ADD start.sh /start.sh

CMD ["/start.sh"]
