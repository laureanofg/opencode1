FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    curl \
    bash \
    ca-certificates \
    sudo \
    xdg-utils \
    zip \
    unzip \
    wget \
    gnupg \
    openssh-client \
    lsb-release \
    apt-transport-https \
    software-properties-common \
    ripgrep \
    fd-find \
    jq \
    tree \
    less \
    procps \
    tmux \
    lsof \
    nano \
    vim \
    python3 \
    python3-pip \
    python3-venv \
    dnsutils \
    iputils-ping \
    netcat-openbsd \
    htop \
    net-tools \
    telnet \
    traceroute \
    sqlite3 \
    && rm -rf /var/lib/apt/lists/*

# Node.js 22 LTS
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs
    
RUN useradd -m -s /bin/bash opencode \
    && echo "opencode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER opencode
WORKDIR /home/opencode

RUN curl -fsSL https://opencode.ai/install | bash

ENV PATH="/home/opencode/.opencode/bin:${PATH}"

USER root

COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

USER opencode

EXPOSE 4096
EXPOSE 37701

CMD ["/usr/local/bin/start.sh"]
