#!/bin/bash


if [ "$1" == "delete" ];  then
    docker stop gowebapp-mysql
    docker rm gowebapp-mysql
    docker stop gowebapp
    docker rm gowebapp
    exit 0
fi

# build backend
cd ../lab01/backend/
docker build \
       -t localhost:5000/gowebapp-mysql:v1 \
       -t gowebapp-mysql:v1 .
docker run \
       --net gowebapp \
       --name gowebapp-mysql \
       --hostname gowebapp-mysql \
       -e MYSQL_ROOT_PASSWORD=heptio \
       -d gowebapp-mysql:v1
cd ../../lab02/

# let mysql start or something
sleep 10

# build frontend
cd frontend/
docker build \
       -t gowebapp:v2 \
       -t localhost:5000/gowebapp:v2 .
docker run \
       -p 9000:80 \
       --net gowebapp \
       --name gowebapp \
       --hostname gowebapp \
       -d gowebapp:v1
cd ..

# todo check if site is up?

docker push localhost:5000/gowebapp:v2
docker push localhost:5000/gowebapp-mysql:v1
