#!/bin/bash
umask 000

exec /sbin/setuser mwlib /usr/local/bin/postman --cachedir /data/mwcache/ >> /data/mwcache/postman.log 
