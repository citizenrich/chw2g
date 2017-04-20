# chw2g




```bash
go get -u github.com/golang/dep/...
dep init
dep ensure -update
docker build -t chw2g .
docker run -it --rm --name instance4 -p 8000:8000 chw2g chw2g
```

issues, then check it out without running the web server.

```bash
docker run -it --entrypoint /bin/sh chw2g
```
