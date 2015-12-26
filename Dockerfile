FROM ubuntu:14.04

# ssh server
RUN \
    apt-get update \
    && apt-get install -y openssh-server \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo 'root:weakpass' | chpasswd

# tool
RUN apt-get install -y vim debconf-utils

# mysql
RUN \
    echo 'mysql-server mysql-server/root_password password mysqlpass' | debconf-set-selections \
    && echo 'mysql-server mysql-server/root_password_again password mysqlpass' | debconf-set-selections \
    && apt-get -y install mysql-client mysql-server \
    && sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# RUN echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'adminpass' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql -uroot -pmysqlpass

# lamp
RUN \
    apt-get install -y apache2 \
    && apt-get install -y libapache2-mod-auth-mysql php5-mysql \
    && apt-get install -y php5 php5-cli php5-mysql php-pear php5-gd  php5-mcrypt php5-curl \
    && sed -i 's/DirectoryIndex.*/DirectoryIndex index.php index.html/' /etc/apache2/mods-available/dir.conf



# enable apache rewrite
RUN \ 
    a2enmod rewrite \
    && sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

VOLUME /var/www/html

ADD vimrc /root/.vimrc

ADD start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 22 80
CMD ["/start.sh"]
