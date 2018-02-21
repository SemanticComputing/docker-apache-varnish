
FROM varnish

RUN apt-get update
RUN apt-get install -y apache2
RUN apt-get install -y gettext-base
RUN apt-get install -y php

# Install php5 from jessie
RUN echo "deb  http://deb.debian.org/debian jessie main" >> /etc/apt/sources.list
RUN echo "deb-src  http://deb.debian.org/debian jessie main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y php5
RUN apt-get install -y libapache2-mod-php5

RUN a2dismod ssl
RUN a2enmod rewrite

RUN chgrp -R root /var/log/apache2
RUN chmod -R g+rwX /var/log/apache2
RUN chmod -R g+rwX /var/run/apache2

