# The Dockerfile in this project sets up the game application with the following steps:
# - It uses the Ubuntu 22.04 base image.
# - Installs Nginx, zip, and curl packages.
# - Configures Nginx to serve the 2048 game.
# - Downloads the 2048 game source code from GitHub.
# - Unzips and moves the game files to the appropriate location.
# - Exposes port 80 for accessing the game.
# - Starts Nginx as the main process.

FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y nginx zip curl

RUN echo "daemon off;" >>/etc/nginx/nginx.conf
RUN curl -o /var/www/html/master.zip -L https://codeload.github.com/gabrielecirulli/2048/zip/master
RUN cd /var/www/html/ && unzip master.zip && mv 2048-master/* . && rm -rf 2048-master master.zip

EXPOSE 80

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]