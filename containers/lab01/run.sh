#!/bin/bash


if [ "$1" == "delete" ];  then
    docker stop gowebapp-mysql
    docker stop gowebapp
    exit 0
fi

# build backend
cd backend/
docker build -t gowebapp-mysql:v1 .
docker run \
       --net gowebapp \
       --name gowebapp-mysql \
       --hostname gowebapp-mysql \
       -e MYSQL_ROOT_PASSWORD=heptio \
       -d --rm gowebapp-mysql:v1
cd ..

# build frontend
cd frontend/
docker build -t gowebapp:v1
docker run \
       -p 9000:80 \
       --net gowebapp \
       --name gowebapp \
       --hostname gowebapp \
       -d --rm gowebapp:v1
cd ..
