#sample docker file to check kaniko build

FROM node:14-alpine

# Install test npm
RUN npm install -g npm

# can be changed for now npm keeping it as /app
WORKDIR /app

# Copy the code
COPY . .

# just exposing port - just test
EXPOSE 3000

# default npm start
CMD ["npm", "start"]
