#!/bin/bash
umask 000

exec /sbin/setuser mwlib /usr/local/bin/nslave --cachedir /data/mwcache/ >> /data/mwcache/nslave.log 
