FROM library/debian:jessie
MAINTAINER Kenneth Peiruza <kenneth@floss.cat>
RUN apt-get -qq update && \
  apt-get -qqy install libapache2-mod-php5 php5-mysql php5-gd php5-curl php5-redis php5-memcached php-pear && \
  rm -rf /var/lib/{apt,dpkg} /var/cache/apt /usr/share/man /usr/share/doc
ENTRYPOINT [ "/usr/sbin/apachectl", "-D", "FOREGROUND" ]
EXPOSE 80:80
