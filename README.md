# APACHE+VARNISH
This container contains apache, varnish and php used in many of the web services.

# Docker build

```
./docker-build.sh [-c]
```
* -c
    * no cache
Generates an image named `apache-varnish` or `apache-varnish-php5` depending on whether building from `master` or `php5` barnch. Requires the `varnish` image. See the `docker-varnish` -repository for building it.
