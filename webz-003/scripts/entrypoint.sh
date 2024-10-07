#!/bin/bash

# Start Corosync and Pacemaker
service corosync start
service pacemaker start
service pcsd start


# Authenticate and start cluster
if [ ! -f /pcs_configured ]; then
  echo "hacluster:12341234" | chpasswd
  echo "172.20.0.2 webz-001" >> /etc/hosts
  echo "172.20.0.3 webz-002" >> /etc/hosts
  echo "172.20.0.4 webz-003" >> /etc/hosts

  pcs cluster auth webz-002 -u hacluster -p 12341234
  pcs cluster start --all

  touch /pcs_configured
fi

# Run Apache2 start script
/start_apache.sh 

# Keep container running
tail -f /dev/null
