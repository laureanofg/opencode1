FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Actualizar e instalar dependencias (limpiado de duplicados y sintaxis corregida)
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-transport-https \
    bash \
    ca-certificates \
    curl \
    dnsutils \
    fd-find \
    git \
    gnupg \
    htop \
    iputils-ping \
    jq \
    less \
    lsof \
    lsb-release \
    nano \
    net-tools \
    netcat-openbsd \
    nodejs \
    npm \
    openssh-client \
    procps \
    python3 \
    python3-pip \
    python3-venv \
    ripgrep \
    software-properties-common \
    sudo \
    telnet \
    tmux \
    traceroute \    
    tree \
    unzip \
    vim \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Crear usuario y otorgar permisos sudo
RUN useradd -m -s /bin/bash opencode \
    && echo "opencode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER opencode
WORKDIR /home/opencode

# Instalar OpenCode usando flags que evitan fallos silenciosos (-fL) 
# e indicando al bash que corra en modo no interactivo si el script lo soporta
RUN curl -fsSL https://opencode.ai/install | bash -s -- --yes || (echo "Fallo la instalacion de OpenCode" && exit 1)

ENV PATH="/home/opencode/.opencode/bin:${PATH}"

# Puerto web/API
EXPOSE 4097

# Mantener web server activo
CMD ["opencode", "web", "--hostname", "0.0.0.0", "--port", "4097"]
