FROM mkoch/base:latest
MAINTAINER Michael Koch <michael.koch@enough.de>

ENV DEBIAN_FRONTEND noninteractive

RUN \
	apt-get update && \
	apt-get install -y --no-install-recommends tinyproxy && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/tinyproxy && \
	chown nobody /var/run/tinyproxy

RUN touch /var/log/tinyproxy/tinyproxy.log && \
	chown nobody /var/log/tinyproxy/tinyproxy.log

RUN \
	sed -i -e 's/Allow /#Allow /' /etc/tinyproxy.conf

EXPOSE 8888

USER nobody
ENTRYPOINT ["/usr/sbin/tinyproxy", "-d"]

