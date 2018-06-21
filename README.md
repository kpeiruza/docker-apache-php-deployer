# php-deployer Docker (Apache@Debian:9)
A Docker container able to deploy any PHP+MySQL APP from parameters

docker run -d -p 8000:80 -e URL="http://your/tar-or-zip/packaged-app" kpeiruza/php-deploy

_docker run -d --name wordpress -p 8000:80 -e URL="https://wordpress.org/latest.tar.gz" kpeiruza/php-deploy_

_docker run -d --name dokuwiki -p 8000:80 -e URL="https://download.dokuwiki.org/out/dokuwiki-c5525093cf2c4f47e2e5d2439fe13964.tgz" kpeiruza/php-deploy_
