FROM registry.access.redhat.com/ubi8/ubi

RUN yum -y install --disableplugin=subscription-manager curl && \
    yum clean all 

ADD root /

USER 1001
WORKDIR /tmp

ENTRYPOINT ["entrypoint.sh"]
