FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y apache2 pacemaker corosync pcs iproute2 iputils-ping wget curl tzdata mysql-server && \
    apt-get clean && \
    ln -fs /usr/share/zoneinfo/Asia/Jerusalem /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

COPY scripts/entrypoint.sh /entrypoint.sh
COPY config/corosync.conf /etc/corosync/corosync.conf
COPY scripts/start_apache.sh /start_apache.sh
RUN chmod +x /entrypoint.sh /start_apache.sh
RUN chmod +x /start_apache.sh

EXPOSE 80 3306 2224

ENTRYPOINT ["/entrypoint.sh"]
