FROM debian:latest
MAINTAINER veto<veto@myridia.com>
RUN apt-get update && apt-get install -y \
  apache2 \
  apt-transport-https \ 
  lsb-release \
  ca-certificates \
  curl \
  wget \	      
  apt-utils \
  openssh-server \
  supervisor \
  redis-server \
  mysql-client \
  libpcre3-dev \
  gcc \
  make \
  emacs25-nox \ 
  git \
  gnupg \
  sqlite3 \
  unzip 




RUN curl https://packages.sury.org/php/apt.gpg | apt-key add -
RUN echo "deb https://packages.sury.org/php/ stretch  main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
  php7.3 \
  php7.3-json \
  php7.3-xml \
  php7.3-cgi  \
  php7.3-mysql  \
  php7.3-mbstring \
  php7.3-gd \
  php7.3-curl \
  php7.3-zip \
  php7.3-dev \
  php7.3-sqlite3 \ 
  php7.3-ldap \
  php7.3-sybase \ 
  php-redis \
  libapache2-mod-php7.3 \
  php-pear \
  composer




RUN echo "<?php phpinfo() ?>" > /var/www/html/index.php ; \
mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor ; \
a2enmod rewrite  ;\
sed -i -e '/memory_limit =/ s/= .*/= 2056M/' /etc/php/7.3/apache2/php.ini ; \
sed -i -e '/post_max_size =/ s/= .*/= 800M/' /etc/php/7.3/apache2/php.ini ; \
sed -i -e '/max_file_uploads =/ s/= .*/= 200/' /etc/php/7.3/apache2/php.ini ; \
sed -i -e '/upload_max_filesize =/ s/= .*/= 800M/' /etc/php/7.3/apache2/php.ini ; \
sed -i -e '/display_errors =/ s/= .*/= ON/' /etc/php/7.3/apache2/php.ini ; \
sed -i -e '/short_open_tag =/ s/= .*/= ON/' /etc/php/7.3/apache2/php.ini ; \
sed -i -e '/short_open_tag =/ s/= .*/= ON/' /etc/php/7.3/cli/php.ini ; \
sed -i -e '/AllowOverride / s/ .*/ All/' /etc/apache2/apache2.conf ; \
sed -i -e '/max_execution_time =/ s/= .*/= 1200/' /etc/php/7.3/apache2/php.ini ; 



RUN pear install mail \
pear upgrade MAIL Net_SMTP \
mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor



COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 22 80
CMD ["/usr/bin/supervisord"]


