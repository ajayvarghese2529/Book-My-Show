# Build stage
FROM node:16 AS build
WORKDIR /app
COPY bookmyshow-app/package*.json ./
RUN npm install
COPY bookmyshow-app/ .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
