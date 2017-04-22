FROM golang:1.8.1-alpine
# run from the local, updated branch to be dockerized.
# golang:latest is 700MB, instead use alpine which is 300MB
# this approach provides all the cgo needs, certificates

RUN apk add --update --no-cache git libc-dev

# install dependency tool
RUN go get github.com/golang/dep && go install github.com/golang/dep/cmd/dep

# must be public repo or see: https://divan.github.io/posts/go_get_private/
# RUN go get github.com/citizenrich/chw2g
# copy the local package files to the container workspace
# this works for private or public repos, which git clone will not do
ADD . /go/src/github.com/citizenrich/chw2g

# Setting up working directory
WORKDIR /go/src/github.com/citizenrich/chw2g

# Get dependencies
# must have done dep init in the repo and created the toml file which is in version control
RUN dep ensure -v

# RUN go build
# Build the bookings command inside the container.
RUN go install github.com/citizenrich/chw2g

# Run the bookings microservice when the container starts.
ENTRYPOINT /go/bin/chw2g

# FYI service main.go listens on port 8000.
# Leave uncommented to set port in publish run option for more flexibility
# EXPOSE 8000

# to build and run:
# docker build -t chw2g .
# docker run -it --rm --name instance4 -p 8000:8000 chw2g chw2g
# can send env variable in run command
