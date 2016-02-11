FROM centos:centos6

ENV USER system
ENV HOME /usr/pochi/home/${USER}
ENV SHELL /bin/bash

RUN useradd -u 1000 ${USER}

RUN mkdir -p ${HOME}
RUN chown -R ${USER}:${USER} ${HOME}
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER}

WORKDIR ${HOME}
