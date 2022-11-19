# Pull base image 
FROM httpd:2.4
COPY ./SEO_app/* /usr/local/apache2/htdocs/
#RUN yum update -y
# Maintainer 
MAINTAINER "okevictor.t@gmail.com" 
EXPOSE 80
#CMD ["-DFOREGROUND"]
