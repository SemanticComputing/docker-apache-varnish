
FROM debian:latest

RUN apt-get update
RUN apt-get install -y varnish varnish-modules
RUN apt-get install -y apache2
RUN apt-get install -y php
RUN apt-get install -y git
RUN apt-get install -y gettext-base
RUN apt-get install -y libcap2-bin

# Compile and install varnish vmod 'urlcode'.
RUN apt-get install -y \
    wget \
    dpkg-dev \
		libtool \
		m4 \
		automake \
		pkg-config \
		docutils-common \
		libvarnishapi-dev
RUN cd /tmp \
		&& mkdir urlcode \
		&& cd urlcode \
		&& wget https://github.com/fastly/libvmod-urlcode/archive/master.tar.gz \
		&& tar -xf master.tar.gz \
		&& cd libvmod-urlcode-master \
		&& sh autogen.sh \
		&& ./configure \
		&& make \
		&& make install \
		&& make check
RUN a2dismod ssl
RUN a2enmod rewrite

RUN chmod -R g+rwX /var/log/apache2
RUN chmod -R g+rwX /var/run/apache2
RUN chmod -R g+rwX /var/lib/varnish/
RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/sbin/varnishd

# Create empty file for the site specifiv varnish configuration and give runtime access to it
RUN touch /etc/varnish/site.vcl
RUN chmod -R g+rwX /etc/varnish/site.vcl
RUN chmod -R g+rwX /var/log/varnish

# Copy the main varnish configuration
COPY default.vcl /etc/varnish/default.vcl

# Expose HTTP
EXPOSE 80

# Use this image as base and configure/modify/run the following as needed:
# 1) /etc/apache2/ports.conf                (apache listening ports)
# 2) /etc/apache2/sites-available           (apache vhost config)
# 3) /var/www/html                          (or whatever document root the vhost uses)
# 4) apachectl configtest                   (test the apache config)
# 5) /etc/varnish/default.vcl               (varnish config)
# 6) varnishd -C -f /etc/varnish/default    (test the varnish config)
