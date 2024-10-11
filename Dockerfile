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

# The build output is in /app/www which can be deployed directly to a platform like Railway