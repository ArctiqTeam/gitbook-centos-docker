FROM centos:7
MAINTAINER stewartshea <shea.stewart@arctiq.ca>

# Inspired by billryan/gitbook:base

RUN yum install -y wget git && \
    wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm &&\
    rpm -ivh epel-release-latest-7.noarch.rpm && \
    yum install -y npm libxtst6 libXext libSM libXrender mesa-libGL fontconfig freetype freetype-devel fontconfig-devel libstdc++ libXcomposite && \
    yum install -y npm && \
    npm install gitbook-cli -g
 
# Install gitbook versions
RUN gitbook fetch 3.2.2 

# Install calibre
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"


ENV APP_ROOT=/opt/app-root
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
COPY bin/ ${APP_ROOT}/bin/
COPY docs/ ${APP_ROOT}/docs/
RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd 

WORKDIR ${APP_ROOT}

EXPOSE 4000

CMD ["/bin/bash", "-c", "${APP_ROOT}/bin/run.sh"]
