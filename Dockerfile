# Docker file to build Doxygen builder

# Base image
FROM klab/ubuntu:latest

# About this docker image
LABEL MAINTAINER="Kirubakaran Shanmugam <kribakarans@gmail.com>"
LABEL DESCRIPTION="KLAB Doxygen documentaion builder"

# Install required packages
RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends && \
    apt-get install -y --no-install-recommends apache2 doxygen git graphviz php

# Clean repositories
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy source
WORKDIR /host
COPY src /klab

# Setup workspace
RUN  rm -f /var/www/html/index.html && \
     /klab/write_banner.sh >> /root/.bashrc && \
     cp -f /klab/index.php /var/www/html/index.php && \
     install -D /klab/mkdox.sh /usr/local/bin/mkdox

# Run entrypoint
ENTRYPOINT [ "/klab/init.sh" ]
