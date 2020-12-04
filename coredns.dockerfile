FROM debian:stable-slim

RUN apt-get update && apt-get -uy upgrade
RUN apt-get -y install ca-certificates wget && update-ca-certificates
RUN curl https://coredns.minidump.info/dl/coredns-linux-amd64.zip -o coredns
RUN apt install unzip
RUN unzip coredns

FROM scratch
COPY ./config /config
COPY --from=0 /coredns/coredns /coredns
COPY --from=0 /etc/ssl/certs /etc/ssl/certs

EXPOSE 53/tcp 53/udp

WORKDIR /config
ENTRYPOINT ["/coredns/coredns"]

