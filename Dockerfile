FROM golang:1.8.1-alpine

# Package dependencies
RUN apk add --update --no-cache git libc-dev

# install dependency tool
RUN go get github.com/golang/dep && go install github.com/golang/dep/cmd/dep

# must be public repo or see:
# https://divan.github.io/posts/go_get_private/
RUN go get github.com/citizenrich/chw2g

# Copy project files
WORKDIR /go/src/github.com/citizenrich/chw2g
# COPY . /go/src/github.com/citizenrich/chw2g

# Get dependencies
RUN dep ensure -v
# Compile code
RUN go build

RUN ["chmod", "777", "/go/src/github.com/citizenrich/chw2g"]

ENTRYPOINT /go/src/github.com/citizenrich/chw2g

# EXPOSE 8000
#
# RUN ["chw2g"]
