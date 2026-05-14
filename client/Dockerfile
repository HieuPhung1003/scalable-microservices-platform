FROM node:18-alpine

# Move to working directory /build
WORKDIR /usr/src/app

# Copies package.json and package-lock.json to Docker environment
COPY package*.json ./
 
# Installs all node packages
RUN npm install

# Copy the code into the container
COPY . .

ENV HOST=0.0.0.0

# Export necessary port
EXPOSE 3000
 
# Command to run when starting the container
CMD [ "npm", "start" ]
