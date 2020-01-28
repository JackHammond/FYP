FROM node:10.13-alpine
ENV NODE_ENV production
WORKDIR /usr/src/app
#install app dependencies 
COPY package*.json ./
#COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install

#RUN npm install --production --silent && mv node_modules ../
COPY . .
EXPOSE 4000
CMD node src/index.js
