# Build Stage
FROM node:18-alpine AS build

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

# Remove all other directories except /dist
RUN find / -mindepth 1 -maxdepth 1 ! -name 'dist' -exec rm -rf {} + && mv /dist/* /

# Production Stage
FROM nginx:alpine

# Copy the built files to the Nginx HTML directory
COPY --from=build / /usr/share/nginx/html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]