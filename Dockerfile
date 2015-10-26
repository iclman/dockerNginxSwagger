FROM ubuntu:14.04.3
RUN apt-get install -y nginx
COPY nginx.conf /etc/nginx/
COPY cert.pem /etc/nginx/
COPY key.pem /etc/nginx/
RUN mkdir /home/iclman
RUN mkdir /home/iclman/test
COPY index.html /home/iclman/test/
#RUN service nginx reload
EXPOSE 8443

CMD ["nginx","-g","daemon off;"] 
