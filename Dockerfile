FROM ubuntu:20.04

WORKDIR /app

COPY . .

ENTRYPOINT [ "/bin/bash" ]