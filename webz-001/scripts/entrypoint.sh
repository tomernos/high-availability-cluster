#!/bin/bash

# Start Corosync and Pacemaker
service corosync start
service pacemaker start
service pcsd start

# Authenticate and start cluster
if [ ! -f /pcs_configured ]; then
  /setup_cluster.sh
fi

# generate cluster config
/generate_config.sh

# Run Apache2 start script
/start_apache.sh 

# Keep container running
tail -f /dev/null


