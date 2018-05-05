FROM chef/chefdk:2.5.8

RUN useradd -u 1000 brentwg && \
    mkdir -p /home/brentwg && \
    chown brentwg:brentwg /home/brentwg && \
    RUN usermod -a -G docker brentwg

RUN apt-get install -y \
    curl \
    build-essential \
    docker.io \
    net-tools

USER brentwg

ENV PATH="/opt/chefdk/embedded/bin:${PATH}"

RUN locale-gen en_US.UTF-8 && \
    echo "alias bundle-install='/opt/chefdk/embedded/bin/bundle install --path vendor --binstubs'" >> /home/brentwg/.bashrc && \ 
    echo "export LC_CTYPE=en_US.UTF-8" >> /home/brentwg/.bashrc && \
    echo "export LC_ALL=en_US.UTF-8" >> /home/brentwg/.bashrc
