FROM nginx
MAINTAINER Josue Valencia
WORKDIR html/

COPY html/ /usr/share/nginx/html
