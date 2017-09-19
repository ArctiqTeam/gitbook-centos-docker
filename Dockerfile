FROM centos:7
MAINTAINER stewartshea <shea.stewart@arctiq.cam>

#inspired by billryan/gitbook:base

RUN yum install -y wget git && \
    wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm &&\
    rpm -ivh epel-release-7-10.noarch.rpm && \
    yum install -y npm && \
    npm install gitbook-cli -g


# install gitbook versions
RUN gitbook fetch latest

ENV BOOKDIR /gitbook

WORKDIR $BOOKDIR

RUN chgrp -R 0 $BOOKDIR && \
    chmod -R g=u $BOOKDIR

ADD scripts/run.sh /gitbook/
RUN chmod +x /gitbook/run.sh


VOLUME $BOOKDIR
EXPOSE 4000

CMD ["/bin/bash", "-c", "/gitbook/run.sh"]
