FROM node:5.11.0-slim

WORKDIR /app

ENV http_proxy http://proxyw.example.com:8080
ENV https_proxy http://proxyw.example.com:8080
RUN npm install -g nodemon
ADD package.json /app/package.json
RUN npm config set registry http://registry.npmjs.org
RUN npm install && npm ls
RUN mv /app/node_modules /node_modules

ADD . /app

ENV PORT 80
EXPOSE 80

CMD ["node", "server.js"]
