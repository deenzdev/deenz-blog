# Stage 1: Build Hugo site
FROM hugomods/hugo:debian-std-git-non-root-0.148.2 AS builder

# Copy entire Hugo site
COPY . /src
WORKDIR /src

# Clean public/ just in case
RUN rm -rf public && \
    hugo --minify -b https://www.deenzcan.com

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Clean default HTML dir (fix typo from 'nginxx' to 'nginx')
RUN rm -rf /usr/share/nginx/html/*

# Copy built Hugo site from builder stage
COPY --from=builder /src/public /usr/share/nginx/html

# Optional: custom Nginx config
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
