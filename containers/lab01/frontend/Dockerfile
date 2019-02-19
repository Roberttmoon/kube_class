FROM golang as builder
LABEL maintainer "education@heptio.com"

EXPOSE 80

ENV GOPATH=/go

WORKDIR /tmp/
ADD https://s3-us-west-2.amazonaws.com/heptio-training/k8shandson/files/gowebapp.tar .
RUN tar -xvf gowebapp.tar
RUN mv /tmp/gowebapp/gowebapp/code $GOPATH/src/gowebapp

WORKDIR $GOPATH/src/gowebapp
RUN ls
RUN go get && go install

FROM golang as runner

COPY --from=builder \
        $GOPATH/bin/gowebapp \
        $GOPATH/bin/gowebapp

COPY --from=builder \
        $GOPATH/src/gowebapp/config \
        /tmp/site/config

COPY --from=builder \
        $GOPATH/src/gowebapp/static \
        /tmp/site/static

COPY --from=builder \
        $GOPATH/src/gowebapp/template \
        /tmp/site/template

WORKDIR /tmp/site/
ENTRYPOINT ["$GOPATH/bin/gowebapp"]
