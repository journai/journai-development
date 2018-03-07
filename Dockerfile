# specify the node base image with your desired version node:<version>
FROM node:6
# replace this with your application's default port

RUN npm install nodemon -g

WORKDIR /home/

RUN git clone https://journai:noway123@github.com/journai/journai-authentication.git

EXPOSE 8888