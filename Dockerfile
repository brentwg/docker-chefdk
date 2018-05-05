FROM chef/chefdk:2.5.8

USER root

RUN groupadd docker -g 132 

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

RUN useradd -u 1000 brentwg && \
    usermod -a -G docker brentwg && \
    mkdir -p /home/brentwg && \
    chown -R brentwg:brentwg /home/brentwg && \
    echo "brentwg ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/brentwg && \
    chmod 0440 /etc/sudoers.d/brentwg

RUN locale-gen en_US.UTF-8

USER brentwg

ENV PATH="/opt/chefdk/embedded/bin:${PATH}"

RUN echo "alias bundle-install='/opt/chefdk/embedded/bin/bundle install --path vendor --binstubs'" >> /home/brentwg/.bashrc && \ 
    echo "export EDITOR=vim" >> /home/brentwg/.bashrc && \
    echo "export LC_CTYPE=en_US.UTF-8" >> /home/brentwg/.bashrc && \
    echo "export LC_ALL=en_US.UTF-8" >> /home/brentwg/.bashrc
