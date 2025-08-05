FROM nginx:alpine

RUN rm -rf /usr/share/nginxx/html/*

COPY public /usr/share/nginx/html

# Copy my own .conf (optional but recommended...got none yet)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]