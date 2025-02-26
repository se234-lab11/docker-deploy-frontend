# Stage 0: Build Angular app
FROM node:10-alpine as node

WORKDIR /app

COPY package*.json /app/

RUN npm install

COPY . /app/

ARG TARGET=deployed

RUN npm run ${TARGET}

# Stage 1: Deploy using Nginx
FROM nginx:1.13

COPY --from=node /app/dist/ /usr/share/nginx/html

COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
EXPOSE 80