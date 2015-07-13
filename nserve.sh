#!/bin/bash
umask 000

exec /sbin/setuser mwlib /usr/local/bin/nserve >> /data/mwcache/nserve.log 
