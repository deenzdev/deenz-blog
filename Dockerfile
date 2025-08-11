# Stage 1: Build Hugo site
FROM hugomods/hugo:reg-node-0.148.2 AS builder

WORKDIR /site
COPY . .
RUN hugo --minify -b https://www.deenzcan.com

# Stage 2: Serve with Nginx
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /site/public /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
