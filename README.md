# GitBook CentOS Docker Container

Gitbook implementation on a CentOS based container. 

This image includes a `docs` directory in which you can place your 
GitBook content.

This container has been run and tested in OpenShift by simply running: 

```
oc new-app https://github.com/ArctiqTeam/gitbook-centos-docker
```
```
oc expose svc gitbook-centos-docker
```
Alternatively, `/bin/run.sh` can be edited to clone another repo for
documentation rendering as required.
