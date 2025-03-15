FROM alpine:3.21.3

WORKDIR /
RUN apk update && apk add nginx wget && \
    adduser -D -g 'www' www && mkdir /www && \
    wget https://raw.githubusercontent.com/pys0530/Jenkins-pipe/refs/heads/main/nginx/nginx.conf && \
    wget https://raw.githubusercontent.com/pys0530/Jenkins-pipe/refs/heads/main/nginx/index.html && \
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup && \
    mv ./nginx.conf /etc/nginx && \
    mv ./index.html /www && \
    chown -R www:www /var/lib/nginx /www && \
    nginx -s reload

CMD ["nginx", "-g", "daemon off;"]