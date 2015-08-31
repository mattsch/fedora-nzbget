#!/usr/bin/env bash

# Check our uid/gid, change if env variables require it
if [ "$( id -u nzbget )" -ne "${LUID}" ]; then
    usermod -o -u ${LUID} nzbget
fi

if [ "$( id -g nzbget )" -ne "${LGID}" ]; then
    groupmod -o -g ${LGID} nzbget
fi

# Copy over our default config if one isn't there
if [ ! -f "/config/nzbget.conf" ]; then
    cp /opt/nzbget/nzbget.conf /config/nzbget.conf
fi

# Set permissions
chown -R nzbget:nzbget /config/nzbget.conf /opt/nzbget

exec runuser -l nzbget -c '/opt/nzbget/nzbget -s -c /config/nzbget.conf -o outputmode=log > /dev/null'
