# apache-varnish

## Notes
Following are defined in this image:

```
ENV PATH_VAR_APACHE "/var/run/apache2"
ENV APACHE_LOG_DIR "/var/log/apache2"
ENV FILE_LOG_APACHE_ERROR "$APACHE_LOG_DIR/error.log"
ENV FILE_LOG_APACHE_ACCESS "$APACHE_LOG_DIR/access.log"
ENV FILE_CONF_PORTS "/etc/apache2/ports.conf"
ENV FILE_CONF_VHOST "/etc/apache2/sites-available/000-default.conf"
```
You can use these in you downstream image for log locations


## Building

```
./docker-build.sh [-c]
```
* -c
    * no cache


## Running in docker

```
./docker-run.sh
```
The service is available at localhost:8080 by default.


## Debugging in docker

```
docker exec -it <container-name> bash`
```

Opens bash inside the running container.


## Running on Rahti

### Initialize OpenShift resources

```
./rahti-init.sh
```
Can be done via the web intarface as well. See rahti-params.sh for the template and parameters to use.

### Rebuild the service

```
./rahti-rebuild.sh
```
Can be done via the web interface as well. Navigate to the BuildConfig in question and click "Start Build"

### Remove the OpenShift resources

```
./rahti-scrap.sh
```

### Webhooks

The template also generates WebHook for triggering the build followed by redeploy.
You can see the exact webhook URL with e.g. following commands
```
oc describe bc <ENVIRONMENT>-<APP_NAME> | grep -A 1 "Webhook"
oc describe bc -l "app=<APP_NAME>,environment=<ENVIRONMENT>"
```
or via the OpenShift web console by navigating to the BuildConfig in question.
