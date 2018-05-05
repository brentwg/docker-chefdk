FROM chef/chefdk:2.5.8

ARG DOCKERGID
ARG USER

USER root

RUN groupadd docker -g ${DOCKERGID} 

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y \
    sudo \
    curl \
    build-essential \
    docker.io \
    net-tools \
    locales \
    vim

RUN useradd -u 1000 ${USER} && \
    usermod -a -G docker ${USER} && \
    mkdir -p /home/${USER} && \
    chown -R ${USER}:${USER} /home/${USER} && \
    echo "${USER} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER}

RUN locale-gen en_US.UTF-8

USER ${USER}

ENV PATH="/opt/chefdk/embedded/bin:${PATH}"

RUN echo "alias bundle-install='/opt/chefdk/embedded/bin/bundle install --path vendor --binstubs'" >> /home/${USER}/.bashrc && \ 
    echo "export EDITOR=vim" >> /home/${USER}/.bashrc && \
    echo "export LC_CTYPE=en_US.UTF-8" >> /home/${USER}/.bashrc && \
    echo "export LC_ALL=en_US.UTF-8" >> /home/${USER}/.bashrc
