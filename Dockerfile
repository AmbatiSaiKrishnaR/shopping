# Stage 1: Build Stage
FROM node:14-alpine AS builder
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Stage 2: Production Stage
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html

# Use sed to change the default Nginx port from 80 to 3000
RUN sed -i 's/listen  .*/listen 3000;/' /etc/nginx/conf.d/default.conf

EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
