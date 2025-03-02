# Use a base image with bash and jq installed
FROM alpine

# Install required packages
RUN apk add --no-cache bash docker-cli jq

# Copy the bash script into the container
#COPY test.sh /usr/local/bin/test.sh
COPY generate_docker_html.sh /usr/local/bin/generate_docker_html.sh

# Make the script executable
RUN chmod +x /usr/local/bin/generate_docker_html.sh

# Define the command to run the script
CMD ["generate_docker_html.sh"]