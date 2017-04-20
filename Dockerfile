FROM golang:1.8.1-alpine

# Package dependencies
RUN apk add --update --no-cache git libc-dev

# install dependency tool
RUN go get github.com/golang/dep && go install github.com/golang/dep/cmd/dep

# Copy project files
WORKDIR /go/src/github.com/citizenrich/chw2g
COPY . /go/src/github.com/citizenrich/chw2g

# Get dependencies
RUN dep ensure -v
# Compile code
RUN go build

EXPOSE 8000

RUN ["/go/src/github.com/citizenrich/chw2g/chw2g"]
