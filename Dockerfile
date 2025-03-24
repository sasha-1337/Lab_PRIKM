FROM nginx:latest
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./image2.jpg /usr/share/nginx/html/image2.jpg
