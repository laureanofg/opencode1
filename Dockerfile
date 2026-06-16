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
    nodejs \
    npm \
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

# Crear usuario
RUN useradd -m -s /bin/bash opencode \
    && echo "opencode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER opencode
WORKDIR /home/opencode

# Instalar OpenCode
RUN curl -fsSL https://opencode.ai/install | bash

ENV PATH="/home/opencode/.opencode/bin:${PATH}"

# Copiar script de inicio
COPY --chown=opencode:opencode start.sh /home/opencode/start.sh

RUN ls -lah /home/opencode/

RUN chmod +x /home/opencode/start.sh

# Puerto OpenCode
EXPOSE 4096

# Puerto Claude-Mem Worker
EXPOSE 37701

CMD ["/home/opencode/start.sh"]
