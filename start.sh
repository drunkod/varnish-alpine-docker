#!/bin/sh

mkdir -p /var/lib/varnish/`hostname` && chown nobody /var/lib/varnish/`hostname`
varnishlog &
if [ -z ${VARNISH_CONFIG} ]; then
  varnishd -F -s ${VARNISH_CACHE} -a :80 -b ${VARNISH_BACKEND_ADDRESS}:${VARNISH_BACKEND_PORT} -p vcc_allow_inline_c=on
else
  varnishd -F -f /etc/varnish/default.vcl -s ${VARNISH_CACHE} -a :80 -p vcc_allow_inline_c=on
fi
