ARG varnish_version=latest
FROM secoresearch/varnish:${varnish_version}

# INSTALL
RUN apt-get update
# PHP 8.1
RUN apt-get install -y curl lsb-release
RUN curl -sSL https://packages.sury.org/php/README.txt | bash -x
RUN apt-get install -y apache2
RUN apt-get install -y php8.1
RUN apt-get install -y php8.1-xml
RUN apt-get install -y php8.1-mbstring
RUN apt-get install -y php8.1-curl
RUN apt-get install -y php8.1-zip

RUN a2dismod ssl
RUN a2enmod rewrite
RUN a2enmod cgi

# add symlink /etc/php/current for not breaking docker child images' php configuration changes when php version is updated
RUN ln -s /etc/php/8.1 /etc/php/current

# ENVIRONMENT VARIABLES
ENV PATH_LOG_VARNISH "/var/log/varnish"
ENV FILE_LOG_VARNISH "$PATH_LOG_VARNISH/varnish.log"
ENV PATH_VAR_APACHE "/var/run/apache2"
ENV APACHE_LOG_DIR "/var/log/apache2"
ENV FILE_LOG_APACHE_ERROR "$APACHE_LOG_DIR/error.log"
ENV FILE_LOG_APACHE_ACCESS "$APACHE_LOG_DIR/access.log"
ENV FILE_CONF_PORTS "/etc/apache2/ports.conf"
ENV FILE_CONF_VHOST "/etc/apache2/sites-available/000-default.conf"
ENV PATH_HTML "/var/www/html"
ENV APACHE_OPTIONS "Indexes FollowSymlinks"
ENV APACHE_ALLOW_OVERRIDE "None"
ENV FILE_GENERATE_CONF_VHOST_SH "/generate-conf-vhost.sh"

COPY ports.conf "$FILE_CONF_PORTS"
COPY generate-conf-vhost.sh "$FILE_GENERATE_CONF_VHOST_SH"

# PERMISSIONS
RUN mkdir -p "$PATH_LOG_VARNISH"
RUN chgrp -R root "$PATH_LOG_VARNISH"
RUN chmod -R g=u "$PATH_LOG_VARNISH"
RUN mkdir -p "$PATH_VAR_APACHE"
RUN mkdir -p "$APACHE_LOG_DIR"
RUN chgrp -R root "$APACHE_LOG_DIR"
RUN chmod -R g=u "$APACHE_LOG_DIR"
RUN chmod -R g=u "$PATH_VAR_APACHE"
RUN touch "$FILE_CONF_PORTS"; chgrp root "$FILE_CONF_PORTS"; chmod -R g+rw "$FILE_CONF_PORTS"
RUN rm "$FILE_CONF_VHOST"; touch "$FILE_CONF_VHOST"; chgrp root "$FILE_CONF_VHOST"; chmod -R g+rw "$FILE_CONF_VHOST"
RUN mkdir -p "$PATH_HTML"; chgrp root "$PATH_HTML"; chmod -R g=u "$PATH_HTML"

ENV RUN_APACHE_VARNISH /run-apache-varnish.sh
ENV EXEC_APACHE_VARNISH "exec $RUN_APACHE_VARNISH"
COPY run "$RUN_APACHE_VARNISH"

ENTRYPOINT [ "/run-apache-varnish.sh" ]
