# Use Ubuntu 18.04 as the base image
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# Update the package manager and install Apache, Pacemaker, Corosync, and PCS
RUN apt-get update && \
    apt-get install -y apache2 net-tools iputils-ping curl wget nano pacemaker corosync pcs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -fs /usr/share/zoneinfo/Asia/Jerusalem /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Create necessary directories for Corosync
RUN mkdir -p /etc/corosync

# Copy the Corosync configuration from the host machine to the container
COPY corosync.conf /etc/corosync/corosync.conf

COPY authkey /etc/corosync/authkey

# Setup index.html for Apache web server
RUN echo "Junior DevOps Engineer - Home Task" > /var/www/html/index.html


# HTTP
EXPOSE 80
# PCS daemon
EXPOSE 2224  
# Corosync
EXPOSE 3121  
# Corosync
EXPOSE 5405  
# Pacemaker
EXPOSE 21064 


# Start Apache, Corosync, and Pacemaker together in the foreground
RUN service corosync start && \
    service pacemaker start && \
    service pcsd start


CMD ["apachectl", "-D", "FOREGROUND"]