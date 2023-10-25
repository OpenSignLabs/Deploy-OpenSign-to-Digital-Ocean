# Use the official MongoDB imagee
FROM mongo:latest

# Create a directory to host initialization scripts
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy default data JSON files to the initialization directory
COPY ./default-data/*.json /docker-entrypoint-initdb.d/

# Copy a custom initialization script that imports the default data
COPY ./mongo-init.sh /docker-entrypoint-initdb.d/

# Make the initialization script executable
RUN chmod +x /docker-entrypoint-initdb.d/mongo-init.sh

# MongoDB environment variables (optional)
ENV MONGO_INITDB_ROOT_USERNAME=root
ENV MONGO_INITDB_ROOT_PASSWORD=example

# Execute the initialization script during container startup
CMD ["mongod", "--auth"]
