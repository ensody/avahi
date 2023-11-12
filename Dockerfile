FROM alpine:latest

WORKDIR /app

RUN apk --no-cache add tini avahi && rm -rf /etc/avahi/services/*
COPY avahi-daemon.conf /etc/avahi/

CMD ["tini", "--", "avahi-daemon"]
