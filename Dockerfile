FROM centos:7
MAINTAINER stewartshea <shea.stewart@arctiq.cam>

#inspired by billryan/gitbook:base

RUN yum install -y wget git && \
    wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm &&\
    rpm -ivh epel-release-7-10.noarch.rpm && \
    yum install -y npm && \
    npm install gitbook-cli -g


ENV APP_ROOT=/opt/app-root
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
COPY bin/ ${APP_ROOT}/bin/
RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd

# install gitbook versions
RUN gitbook fetch latest


USER 10001
WORKDIR ${APP_ROOT}


EXPOSE 4000

# ENTRYPOINT [ "uid_entrypoint" ]

VOLUME ${APP_ROOT}/logs ${APP_ROOT}/data

CMD ["/bin/bash", "-c", "${APP_ROOT}/bin/run.sh"]
