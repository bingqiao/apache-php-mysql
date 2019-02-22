# Centos based container with Apache, PHP and MySql
FROM centos:7
MAINTAINER bingqiao <bqiaodev@gmail.com>

# Install prepare infrastructure
RUN yum -y update && \
yum -y install wget tar unzip && \
yum -y install lsof && \
yum -y install epel-release yum-utils && \
yum -y install httpd && \
yum -y install python36 && \
yum -y install python36-setuptools && \
easy_install-3.6 pip && pip3 install requests

RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
yum-config-manager --enable remi-php73 && \
yum -y install php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd php-mbstring

RUN wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm && \
rpm --force -ivh mysql-community-release-el7-5.noarch.rpm && \
yum -y update && \
yum -y install mysql-server

ADD init.sh /scripts/init.sh
# fix windows carriage return
RUN sed -i -e 's/\r$//' /scripts/init.sh && \
chmod u+x /scripts/init.sh

CMD ["./scripts/init.sh"]

