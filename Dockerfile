FROM alpine:3.21.3

RUN apk update && apk add nginx wget &&\
    adduser -D -g 'www' www && mkdir /www &&\
    chown -R www:www /var/lib/nginx /www &&\
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
    wget 

CMD ["nginx", "-g", "daemon off;"]