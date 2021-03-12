FROM httpd:latest
MAINTAINER Josue Valencia

copy ./index.html /usr/local/apache2/htdocs
