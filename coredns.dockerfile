FROM debian:stable-slim

RUN apt-get update && apt-get -uy upgrade
RUN apt-get -y install ca-certificates wget && update-ca-certificates
RUN apt-get -y install curl unzip
RUN curl -L https://ci.appveyor.com/api/buildjobs/8824uv2c6vigd6p0/artifacts/distrib%2Fcoredns-linux-amd64.zip -o coredns.zip
RUN unzip coredns.zip
RUN mkdir /config

FROM scratch
COPY --from=0 /config /config
COPY --from=0 /coredns-linux-amd64/coredns /coredns
COPY --from=0 /etc/ssl/certs /etc/ssl/certs

EXPOSE 53/tcp 53/udp

WORKDIR /config
ENTRYPOINT ["/coredns"]

