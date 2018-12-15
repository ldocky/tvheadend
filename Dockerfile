FROM ubuntu:bionic
MAINTAINER ldocky 

ENV DEBIAN_FRONTEND=noninteractive

VOLUME /config /recordings

RUN apt-get update && apt-get install -y \
coreutils \
wget \
apt-transport-https \
lsb-release \
gnupg \
ca-certificates

RUN wget --no-check-certificate -qO- https://doozer.io/keys/tvheadend/tvheadend/pgp | apt-key add -

RUN sh -c 'echo "deb https://apt.tvheadend.org/unstable $(lsb_release -sc) main" | tee -a /etc/apt/sources.list.d/tvheadend.list'

RUN apt-get update
RUN apt-get install -y tvheadend

EXPOSE 9981 9982


ENTRYPOINT ["/usr/bin/tvheadend"]
CMD ["--firstrun", "-u", "root", "-g", "root", "-c", "/config"]
