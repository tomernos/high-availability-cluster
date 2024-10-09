#!/bin/bash

# Get the Floating IP
floating_ip=$(pcs cluster cib | grep -E "FloatingIP-instance_attributes-ip" | awk -F'value=' '{print $2}' | tr -d '"/>')

# Fetch the list of Online nodes
node_list=$(pcs status nodes | grep 'Online' | awk -F 'Online: ' '{print $2}' | tr ' ' '\n' | sort | uniq)

script_dir="$(dirname "$(realpath "$0")")"
config_path="$script_dir/cluster_config.txt"

# Create or update the cluster_config.txt file with JSON format
echo "{" > $config_path
echo "  \"Floating_IP\": \"$floating_ip\"," >> $config_path
echo "  \"nodes\": [" >> $config_path

# Loop through each node and get the hostname and IP
for node in $node_list
do
    node_ip=$(getent hosts $node | awk '{ print $1 }' | sort | uniq | head -n 1)
    echo "    { \"name\": \"$node\", \"ip\": \"$node_ip\" }," >> $config_path
done

# Remove the last comma and close the JSON structure
sed -i '$ s/,$//' $config_path
echo "  ]" >> $config_path
echo "}" >> $config_path

