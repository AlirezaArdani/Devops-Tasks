# 1. Dockerfile base on nginx
FROM nginx:latest
# 2. copy app directory inclduding html file
COPY d-index.html /usr/share/nginx/html/index.html
# 3. expose 80 port 
EXPOSE 80
# 4. run nginx in foreground
CMD [ "nginx","-g","daemon off;" ]