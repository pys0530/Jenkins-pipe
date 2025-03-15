FROM alpine:3.21.3

WORKDIR /
RUN apk update && apk add nginx wget
RUN adduser -D -g 'www' www && mkdir /www
RUN wget https://raw.githubusercontent.com/pys0530/Jenkins-pipe/refs/heads/main/nginx/nginx.conf
RUN wget https://raw.githubusercontent.com/pys0530/Jenkins-pipe/refs/heads/main/nginx/index.html
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
RUN mv ./nginx.conf /etc/nginx
RUN mv ./index.html /www
RUN chown -R www:www /var/lib/nginx /www

CMD ["nginx", "-g", "daemon off;"]