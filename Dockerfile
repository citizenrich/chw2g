FROM golang:1.8.1-alpine
# golang:latest is 700MB, instead use golang:alpine which is 300MB
# this approach provides all the cgo needs, certificates

RUN apk add --update --no-cache git libc-dev

# dependencies
RUN go get github.com/golang/dep && go install github.com/golang/dep/cmd/dep

# must be public repo. (https://divan.github.io/posts/go_get_private/)
# RUN go get github.com/citizenrich/chw2g
# instead, copy the local package files to the container workspace
# this works for private or public repos
ADD . /go/src/github.com/citizenrich/chw2g

# Setting up working directory
WORKDIR /go/src/github.com/citizenrich/chw2g

# must have done dep init in the repo and created the toml file which is in version control
RUN dep ensure -v

# Build the command and put it in go/bin
RUN go install github.com/citizenrich/chw2g

# Run the service when the container starts.
ENTRYPOINT /go/bin/chw2g

# FYI service main.go listens on port 8000. Exposed ports can be set in run.
# EXPOSE 8000

# to build and run:
# docker build -t chw2g .
# docker run -it --rm --name instance4 -p 8000:8000 chw2g chw2g
# can add args to make docker build portable for other golang apps
# can send env variable in run command
