# develop stage
FROM node:alpine as build-stage
WORKDIR /app
ARG NPM_TOKEN
COPY package*.json ./
COPY .npmrc .npmrc
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM nginx:alpine as prod-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
