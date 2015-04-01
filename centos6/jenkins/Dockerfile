FROM centos:6

# install http
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# install httpd
RUN yum -y install httpd vim-enhanced bash-completion unzip
RUN sed -i "s^DocumentRoot \"/var/www/html\"^DocumentRoot \"/home/jenkins/workspace/HR/docroot\"^" /etc/httpd/conf/httpd.conf

# php
RUN yum -y install git ant vim mc mysql mysql-server httpd php php-devel php-mysql php-gd php-pear php-xml php-mbstring php-mcrypt php-mssql php-tidy curl curl-devel php-pecl-apc
RUN yum install -y uuid-devel pkgconfig libtool gcc-c++ php-pecl-xdebug php-pecl-uuid git php-intl
RUN yum -y install python-pip
RUN pip install supervisor

ADD ./scripts/start.sh /start.sh
ADD ./scripts/apache.sh /etc/apache2/foreground.sh
ADD ./configs/supervisord.conf /etc/supervisord.conf

RUN chmod 755 /start.sh
RUN chmod 755 /etc/apache2/foreground.sh
RUN mkdir -m 755 /var/log/supervisor/

# zeromq
RUN yum install -y zeromq zeromq-devel
RUN printf "\n" | pecl install zmq-beta
RUN echo "extension=zmq.so" > /etc/php.d/zmq.ini

# xdebug
RUN echo "xdebug.max_nesting_level=200" >> /etc/php.d/xdebug.ini

# start httpd
RUN mkdir -p /home/jenkins/workspace/HR/docroot

RUN echo "NETWORKING=yes" > /etc/sysconfig/network

# install sshd
RUN yum install -y openssh-server openssh-clients passwd
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && echo 'root:changeme' | chpasswd

# Add user jenkins to the image
RUN adduser jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

EXPOSE 22
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]