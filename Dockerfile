FROM chef/chefdk:2.5.8

ARG DOCKERGID
ARG USER

USER root

RUN groupadd docker -g ${DOCKERGID} 

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    sudo \
    curl \
    build-essential \
    net-tools \
    locales \
    vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /var/tmp/*

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y --no-install-recommends docker-ce && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* /var/tmp/*

RUN useradd -u 1000 ${USER} && \
    usermod -a -G docker ${USER} && \
    mkdir -p /home/${USER} && \
    chown -R ${USER}:${USER} /home/${USER} && \
    echo "${USER} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER}

RUN locale-gen en_US.UTF-8

USER ${USER}

ENV PATH="/opt/chefdk/embedded/bin:${PATH}"

WORKDIR /home/${USER}

RUN echo "alias bundle-install='/opt/chefdk/embedded/bin/bundle install --path vendor --binstubs'" >> .bashrc && \ 
    echo "export EDITOR=vim" >> .bashrc && \
    echo "export LC_CTYPE=en_US.UTF-8" >> .bashrc && \
    echo "export LC_ALL=en_US.UTF-8" >> .bashrc
