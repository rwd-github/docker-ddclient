FROM alpine:latest

RUN apk upgrade --no-cache \
	&& apk add --no-cache \
	curl \
	unzip \
	make \
	perl \
	perl-utils \
	perl-test-taint \
	perl-netaddr-ip \
	perl-net-ip \
	perl-yaml \
	perl-log-log4perl \
	perl-io-socket-ssl
RUN cpan Data::Validate::IP

RUN mkdir -p /etc/ddclient/ \
	&& mkdir -p /var/cache/ddclient/
	
RUN DDCLIENT_VERSION=$(curl -sX GET "https://api.github.com/repos/ddclient/ddclient/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') \
	&& echo "DDCLIENT_VERSION=${DDCLIENT_VERSION}" \
	&& curl -o /root/ddclient.tar.gz -L \
	"https://github.com/ddclient/ddclient/archive/${DDCLIENT_VERSION}.tar.gz" \
	&& cd /root \
	&& tar xf ddclient.tar.gz \
	&& cd ddclient* \
	&& cp ddclient /usr/bin/ddclient \
	&& cp sample-etc_ddclient.conf /etc/ddclient/ddclient.conf.original


VOLUME [ "/client/" ]


COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
