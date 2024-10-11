# Build Stage
FROM node:18-alpine as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install npm dependencies
RUN npm install -g npm@latest && npm install -g @ionic/cli && npm install

# Copy the entire code repository to the container
COPY . .

# Run the Ionic production build
RUN ionic build --prod

# Move the build output to a new location for the next stage
RUN mv /app/dist /dist

# Set permissions for the dist directory
RUN chmod -R 755 /dist

# Production Stage
FROM nginx:alpine

# Copy the built files to the Nginx HTML directory
COPY --from=build /dist /usr/share/nginx/html

# Set proper permissions for the files to be served
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Healthcheck to ensure the server is running properly
HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
