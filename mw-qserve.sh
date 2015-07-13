#!/bin/bash
umask 000

exec /sbin/setuser mwlib /usr/local/bin/mw-qserve >> /data/mwcache/mw-qserve.log 
