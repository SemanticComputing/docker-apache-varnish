# APACHE+VARNISH
This container contains apache, varnish and php used in many of the web services.

# Docker build

```
./docker-build.sh [-c]
```
* -c
    * no cache
Generates an image named `apache-varnish` or `apache-varnish-php5` depending on whether building from `master` or `php5` barnch. Requires the `varnish` image. See the `docker-varnish` -repository for building it.

# Environment Variables:
Following are defined in this image:

```
ENV PATH_VAR_APACHE "/var/run/apache2"
ENV APACHE_LOG_DIR "/var/log/apache2"
ENV FILE_LOG_APACHE_ERROR "$APACHE_LOG_DIR/error.log"
ENV FILE_LOG_APACHE_ACCESS "$APACHE_LOG_DIR/access.log"
ENV FILE_CONF_PORTS "/etc/apache2/ports.conf"
ENV FILE_CONF_VHOST "/etc/apache2/sites-available/000-default.conf"
```

The actual log file locations depend on what is defined in the vhost configuration, which is meant to be overridden. Sticking to these defaults is encouraged.

