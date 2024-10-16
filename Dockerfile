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

# Production Stage
FROM nginx:alpine

# Copy the built files to the Nginx HTML directory
COPY --from=build /dist /usr/share/nginx/html

# Copy custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Set proper permissions for the files to be served
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]

# docker run -p 8080:80 --name fafe fafe_test