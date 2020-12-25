#!/bin/sh

mkdir -p /var/lib/varnish/`hostname` && chown nobody /var/lib/varnish/`hostname`
zerotier-one 
varnishlog &

VARNISH_PARAMETERS="-a :80 -p vcc_allow_inline_c=on
    -p thread_pool_min=200
    -p thread_pool_max=4000
    -p thread_pool_add_delay=1
    -p listen_depth=2048"

if [ -z ${VARNISH_CONFIG} ]; then
  varnishd -F -s ${VARNISH_CACHE} -b ${VARNISH_BACKEND_ADDRESS}:${VARNISH_BACKEND_PORT} ${VARNISH_PARAMETERS}
else
  varnishd -F -f /etc/varnish/default.vcl -s ${VARNISH_CACHE} ${VARNISH_PARAMETERS}
fi
