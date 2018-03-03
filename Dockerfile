FROM library/debian:stretch
MAINTAINER kenneth@floss.cat
#	Stripdown & Install
RUN	apt-get update && \
	apt-get -qq -y upgrade && \
	apt-get -y --no-install-recommends install libapache2-mod-php7.0 php-curl php-gettext php-mcrypt php-intl php-soap php-gd ssl-cert unzip tar apache2 wget php-mysql && \
	rm -rf /etc/apache2/conf-enabled/* && \
	ln -s /etc/apache2/conf-available/security* /etc/apache2/conf-enabled/ && \
	a2dismod -f authn_file authz_user status autoindex reqtimeout access_compat alias filter && \
	a2enmod -f rewrite && \
	ln -sf /dev/stdout /var/log/apache2/other_vhosts_access.log && \
	ln -sf /dev/stderr /var/log/apache2/error.log && \
	sed -i "s/.*ServerTokens.*/ServerTokens Prod/" /etc/apache2/conf-available/security.conf && \
	sed -i "s/.*ServerSignature.*/ServerSignature Off/" /etc/apache2/conf-available/security.conf && \
	echo "<DirectoryMatch \"/\.git\">\nRequire all denied\n</DirectoryMatch>" > /etc/apache2/conf-available/403-dotgit.conf && \
	a2enconf security 403-dotgit && \
	rm  -r /var/log/apt/* /var/cache/apt/archives/ /usr/share/doc/ /usr/share/man /usr/include

COPY conf/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY conf/mpm_prefork.conf /etc/apache2/mods-available/mpm_prefork.conf

#	Purga final
COPY bootstrap.sh /
EXPOSE 80
ENTRYPOINT [ "/bootstrap.sh"]
