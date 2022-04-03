FROM ubuntu:20.04

WORKDIR /app

COPY . .

RUN touch /tmp/test.txt

ENTRYPOINT [ "/bin/bash" ]