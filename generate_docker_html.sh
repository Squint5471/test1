#!/bin/bash

# Run docker ps command and capture its output
output=$(docker ps --all --no-trunc --format='{{json .}}')

# Extract container names and ports using jq
container_names=$(echo "$output" | jq -r '.Names')
container_ports=$(echo "$output" | jq -r '.Ports')

# Create HTML file and write header
echo "<html><head><title>Docker Container Ports</title></head><body><h1>Docker Container Ports</h1>" > docker_container_ports.html

# Loop through container names
while IFS= read -r container_name; do
    # Write container name as header
    echo "<h2>$container_name</h2>" >> /home/docker_container_ports.html
    echo "<ul>" >> /home/docker_container_ports.html

    # Loop through container ports
    while IFS= read -r port_info; do
        # Extract the port number
        port=$(echo "$port_info" | awk -F '->' '{print $1}')

        # Write port as list item with link
        echo "<li><a href='http://localhost:$port'>$port</a></li>" >> /home/docker_container_ports.html
    done <<< "$container_ports"

    echo "</ul>" >> /home/docker_container_ports.html
done <<< "$container_names"

# Write closing tags
echo "</body></html>" >> /home/docker_container_ports.html

echo "HTML file generated: /home/docker_container_ports.html"

# Infinite loop that prints a dot
while true; do
    echo .
done