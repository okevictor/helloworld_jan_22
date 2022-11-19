# Pull base image 
FROM httpd:2.4
COPY ./SEO_app/* /usr/local/apache2/htdocs/

# Maintainer 
#MAINTAINER "kserge2001@yahoo.fr" 
