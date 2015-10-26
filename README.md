# dockerNginxSwagger
Setup a Docker image of an nginx server that will do some reverse proxy of Swagger-Editor and Swagger-UI
The Nginx container will listen via HTTPS protocol on port 8443.
The host of the nginx server is a VM on Microsoft Azure Cloud that has the endpoint 443 (Public port) mapped to the endpoint 443 (Private port)

![Diagram](/images/docker-nginx-swagger.JPG)

Usage 

1) Clone swagger-ui into new folder dockerSwaggerUi. Build the Docker image of Swagger-UI and run it as "container_swagui"

    git clone https://github.com/swagger-api/swagger-ui.git dockerSwaggerUi
    cd dockerSwaggerUi
    docker build -t swagger-ui .
    docker run --name=container_swagui -d -t swagger-ui

=> The Swagger-UI will be running on the localhost of the container on port 8080


2) Clone swagger-editor into new folder dockerSwaggerEditor. Build the Docker image of Swagger-Editor and run it as as "container_swaged"

    git clone https://github.com/swagger-api/swagger-editor.git dockerSwaggerEditor
    cd dockerSwaggerEditor
    docker build -t swaggereditor .
    docker run --name=container_swaged -d -t swaggereditor

=> The Swagger-editor will be running on the localhost of the container on port 8080


3) Clone this repository. Modify the certificate and key if you have proper SSL certificate. Build the Docker image  


    git clone https://github.com/iclman/dockerNginxSwagger.git 
    cd dockerNginxSwagger

Modify the files key.pem and cert.pem if you have your own SSL certificate.
Replace the port 8443 by another port number if needed in nginx.conf

Build the dockerNginxSwagger image

    docker build -t nginxswagger .
    docker run -p 443:8443 --link  container_swaged:webswaggereditor --link container_swagui:webswaggerui -d --name=container_nginxswagger -t nginxswagger

=> Assuming the FQDN of your Azure VM is "machine1.cloudapp.net", you should then be able to access your Swagger Editor via
https://machine1.cloudapp.net/swagger-editor/

The Swagger-Ui should be accessible via
https://machine1.cloudapp.net/swagger-ui/

The test page in index.html should be visible via
https://machine1.cloudapp.net/test/
