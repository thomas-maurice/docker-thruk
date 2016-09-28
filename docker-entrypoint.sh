#!/bin/bash

set -x
# TODO: Use some kind of template (j2cli ?) to allow
# more datasources to be added
sed -i "s/LIVESTATUS_CONN/$LIVESTATUS_CONN/" /etc/thruk/thruk.conf
if ! [ -z "$LOGCACHE_CONN" ]; then
    echo "logcache=$LOGCACHE_CONN" >> /etc/thruk/thruk_local.conf
fi;
if ! [ -z "$PORT" ]; then
    # sed the listening port
    sed -i "s/:80/:$PORT/" /etc/apache2/sites-enabled/000-default.conf
    sed -i "s/Listen 80/Listen $PORT/" /etc/apache2/ports.conf
    echo "cookie_auth_restricted_url        = http://localhost:$PORT/thruk/cgi-bin/restricted.cgi" >> /etc/thruk/thruk_local.conf
fi;

echo "ErrorLog /dev/stderr
TransferLog /dev/stdout" >> /etc/apache2/apache2.conf

exec apache2ctl -DFOREGROUND -e info
