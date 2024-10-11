# Build Stage
FROM node:18-alpine as build

# Set the working directory
WORKDIR /

# Copy package.json and package-lock.json
COPY package*.json ./

# Install npm dependencies
RUN npm install -g npm@latest && npm install -g @ionic/cli && npm install

# Copy the entire code repository to the container
COPY . .

# Run the Ionic production build
RUN ionic build --prod

# Install a simple HTTP server for serving static files
RUN npm install -g http-server

# Expose port 8080
EXPOSE 8080

# Start the HTTP server to serve the build output
CMD ["http-server", "/dist", "-p", "8080"]