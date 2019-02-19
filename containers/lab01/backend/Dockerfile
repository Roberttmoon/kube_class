FROM busybox as builder

WORKDIR /tmp/
ADD https://s3-us-west-2.amazonaws.com/heptio-training/k8shandson/files/gowebapp.tar .

FROM mysql:5.6
LABEL maintainer "education@heptio.com"
LABEL version="1.0"

copy --from=builder \
        /tmp/gowebapp/gowebapp-mysql/gowebapp.sql \
        /docker-entrypoint-initdb.d
