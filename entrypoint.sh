#!/bin/sh
set -e
cp /config/ddclient.conf /etc/ddclient/
chmod 600 /etc/ddclient/ddclient.conf
/usr/bin/ddclient -foreground -verbose
