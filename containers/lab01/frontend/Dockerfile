FROM golang
LABEL maintainer "education@heptio.com"

EXPOSE 80

ENV GOPATH=/go

WORKDIR /tmp/
ADD https://s3-us-west-2.amazonaws.com/heptio-training/k8shandson/files/gowebapp.tar .
RUN tar -xvf gowebapp.tar
RUN mv /tmp/gowebapp/gowebapp/code $GOPATH/src/gowebapp

WORKDIR $GOPATH/src/gowebapp
RUN go get && go install

FROM golang as runner

COPY --from=builder \
        /go/bin/gowebapp \
        /go/bin/gowebapp

WORKDIR /tmp/config
COPY --from=builder \
        /go/src/gowebapp/gowebapp/code/config/config.json
        /tmp/config/config.json

ENTRYPOINT ["/go/bin/gowebapp"]
