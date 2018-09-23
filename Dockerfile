FROM phusion/baseimage:latest
MAINTAINER David Young <davidy@funkypenguin.co.nz>

# BUILD_DATE and VCS_REF are immaterial, since this is a 2-stage build, but our build
# hook won't work unless we specify the args
ARG BUILD_DATE
ARG VCS_REF

# Good docker practice, plus we get microbadger badges
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/funkypenguin/docker-mwlib.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="2.2-r1"

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set correct environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV HOME            /root
ENV LC_ALL          C.UTF-8
ENV LANG            en_US.UTF-8
ENV LANGUAGE        en_US.UTF-8

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

RUN useradd mwlib
RUN apt-get update

# Install dependencies
RUN apt-get install -y gcc g++ make python python-pip python-dev\
 python-virtualenv libjpeg-dev libz-dev libfreetype6-dev liblcms-dev\
 libxml2-dev libxslt-dev ocaml-nox git-core python-imaging python-lxml\
 texlive-latex-recommended ploticus dvipng imagemagick pdftk

# Install mwlib & mwlib.rl
RUN pip install -i http://pypi.pediapress.com/simple/ mwlib
RUN pip install -i http://pypi.pediapress.com/simple/ mwlib.rl

# Create cache temporary directories
RUN mkdir -p /data/mwcache
RUN chown -R mwlib:mwlib /data/mwcache

#########################################
##  FILES, SERVICES AND CONFIGURATION  ##
#########################################

# Add services to runit
ADD nserve.sh /etc/service/nserve/run
ADD mw-qserve.sh /etc/service/mw-qserve/run
ADD nslave.sh /etc/service/nslave/run
ADD postman.sh /etc/service/postman/run

RUN chmod +x /etc/service/*/run /etc/my_init.d/*

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

VOLUME /config
EXPOSE 8899
