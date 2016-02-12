FROM centos:centos6

# env
ENV USER system
ENV HOME /usr/pochi/home/${USER}
ENV SHELL /bin/bash

# yum
RUN rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y -q update
RUN yum -y -q install tar bzip2
RUN yum -y -q install mercurial
RUN yum -y -q install ncurses-devel
RUN yum -y -q install make
RUN yum -y -q install gcc
RUN yum -y -q install cmake
RUN yum -y -q install man
RUN yum -y -q install git
RUN yum -y -q install sudo
RUN yum -y -q install nginx patch
RUN yum -y -q install mysql mysql-server mysql-devel
RUN yum -y -q install nodejs npm --enablerepo=epel
RUN yum clean all

# user
RUN useradd -u 1000 ${USER}

RUN mkdir -p ${HOME}
RUN chown -R ${USER}:${USER} ${HOME}
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER}

WORKDIR ${HOME}
