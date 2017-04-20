FROM golang:1.8-alpine

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

RUN ["chw2g"]


# FROM golang:1.8.1-alpine

# WORKDIR /app

# ADD . /go/src/github.com/citizenrich/chw2g/

# ADD $GOPATH/src/github.com/ua-parser/uap-go /go/src/github.com/ua-parser/uap-go
# RUN go install github.com/citizenrich/chw2g
# CMD ["/go/bin/chw2g"]
# EXPOSE 8000

# FROM golang:1.8.1-alpine
#
# WORKDIR /app
#
# ADD $GOPATH/src/github.com/citizenrich/chw2g /go/src/github.com/citizenrich/chw2g
#
# RUN env GOOS=linux GOARCH=amd64 go build github.com/citizenrich/chw2g
#
# # RUN wget https://raw.githubusercontent.com/ua-parser/uap-core/master/regexes.yaml
#
# EXPOSE 8000
#
# CMD ["chw2g"]
