FROM centos:latest

RUN yum -y install curl && \
    yum clean all

ADD root /

USER 1001

ENTRYPOINT ["entrypoint.sh"]
