# Stage 1: Build Hugo site
FROM hugomods/hugo:reg-node-0.148.2 AS builder

WORKDIR /site
COPY . .
RUN hugo --minify -b https://www.deenzcan.com

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Stage 3: Remove default content
RUN rm -rf /usr/share/nginx/html/*

# Stage 4: Copy files from builder stage
COPY --from=builder /site/public /usr/share/nginx/html

# Stage 5: Change permissions so non-root user can read
RUN chown -R nginx:Nginx /usr/share/nginx/html
USER nginx

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
