# apache-varnish

## Notes

### Apache

Environemt variables:
```
PATH_VAR_APACHE # /var/run/apache2
APACHE_LOG_DIR # /var/log/apache2
FILE_LOG_APACHE_ERROR # APACHE_LOG_DIR/error.log
FILE_LOG_APACHE_ACCESS # $APACHE_LOG_DIR/access.log
FILE_CONF_PORTS # /etc/apache2/ports.conf
FILE_CONF_VHOST # /etc/apache2/sites-available/000-default.conf
PATH_HTML # /var/www/html
APACHE_OPTIONS # ="Indexes FollowSymLinks"
APACHE_ALLOW_OVERRIDE # ="None"
RUN_APACHE_VARNISH # ="/run-apache-varnish.sh"
EXEC_APACHE_VARNISH # ="exec $RUN_APACHE_VARNISH"
```

By default, the vhost config file `FILE_CONF_VHOST` is generated at the entrypoint  `RUN_APACHE_VARNISH` using the `generate-cong-vhost.sh` script. The generation can be controlled dollowing environment variables:
* `APACHE_OPTIONS`
	* Controls the Options directive for `PATH_HTML`.
* `APACHE_ALLOW_OVERRIDE`
	* Controls the AllowOverride directive for `PATH_HTML`.
If `FILE_CONF_VHOST` exists and is not empty before entering `RUN_APACHE_VARNISH`, then the vhost conf generation is skipped.

For more complex configuration, override the `FILE_CONF_VHOST` file in a downstream image or mount it. If you have a custom entrypoint, you can launch apache+varnish by typing `$EXEC_APACHE_VARNISH` in a shell.

### Varnish

For details and configuration of the included varnish cache, see the docker-varnish -repository.

## Pulling

rahti-scripts is a submodule therefore you might want to use

```
git clone --recursive
```
and

```
git pull --recurse-submodules
```


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
