FROM centos:centos7
MAINTAINER Darez

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

RUN yum -y update
RUN yum clean all
RUN yum install -y httpd php55w
RUN yum clean all

EXPOSE 80

COPY httpd.conf /httpd.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
