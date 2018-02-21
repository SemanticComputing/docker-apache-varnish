
FROM varnish

RUN apt-get update
RUN apt-get install -y apache2
RUN apt-get install -y gettext-base
RUN apt-get install -y php

RUN a2dismod ssl
RUN a2enmod rewrite

RUN chgrp -R root /var/log/apache2
RUN chmod -R g+rwX /var/log/apache2
RUN chmod -R g+rwX /var/run/apache2

