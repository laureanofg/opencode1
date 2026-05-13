FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    curl \
    bash \
    ca-certificates \
    sudo \
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
    && rm -rf /var/lib/apt/lists/*

# Crear usuario no-root
RUN useradd -m -s /bin/bash opencode \
    && echo "opencode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER opencode
WORKDIR /home/opencode

# Instalar OpenCode
RUN curl -fsSL https://opencode.ai/install | bash

ENV PATH="/home/opencode/.opencode/bin:${PATH}"

CMD ["sleep", "infinity"]
