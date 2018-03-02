FROM varnish

# INSTALL
RUN apt-get update
RUN apt-get install -y apache2
RUN apt-get install -y php
# envsubst from gettext-base can be used to replace environment variables in config files etc.
RUN apt-get install -y gettext-base

RUN a2dismod ssl
RUN a2enmod rewrite
RUN a2enmod cgi

# ENVIRONMENT VARIABLES
ENV PATH_VAR_APACHE "/var/run/apache"
ENV APACHE_LOG_DIR "/var/log/apache"
ENV FILE_LOG_APACHE_ERROR "$APACHE_LOG_DIR/error.log"
ENV FILE_LOG_APACHE_ACCESS "$APACHE_LOG_DIR/access.log"

# PERMISSIONS
RUN mkdir -p "$PATH_VAR_APACHE"
RUN mkdir -p "$APACHE_LOG_DIR"
RUN chgrp -R root "$APACHE_LOG_DIR"
RUN chmod -R u=g "$APACHE_LOG_DIR"
RUN chmod -R u=g "$PATH_VAR_APACHE"
