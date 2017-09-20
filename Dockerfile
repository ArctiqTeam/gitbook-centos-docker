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

ADD scripts/ $BOOKDIR
RUN chmod +x /gitbook/run.sh

RUN chgrp -R 0 $BOOKDIR && \
    chmod -R g=u $BOOKDIR


EXPOSE 4000
RUN chmod g=u /etc/passwd
ENTRYPOINT [ "uid_entrypoint" ]
USER 10001

VOLUME $BOOKDIR
CMD ["/bin/bash", "-c", "/gitbook/run.sh"]
