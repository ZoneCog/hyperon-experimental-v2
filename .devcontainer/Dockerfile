# Use an official Ubuntu base image
FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic dependencies
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
        curl \
        unzip \
        python3 \
        python3-pip \
        openjdk-11-jdk \
        libssl-dev \
        pkg-config \
        libboost-all-dev \
        libsqlite3-dev \
        default-jdk \
        sudo \
        locales \
        gnupg-agent \
        software-properties-common \
        apt-transport-https \
        ca-certificates \
        lsb-release

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install Go (latest stable version)
ENV GO_VERSION=1.20.5
RUN wget https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz && \
    rm go$GO_VERSION.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/home/codespace/go"
ENV PATH="${PATH}:${GOPATH}/bin"

# Install Terraform
ENV TERRAFORM_VERSION=1.5.0
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install CMake (if a newer version is needed)
RUN wget https://github.com/Kitware/CMake/releases/download/v3.25.2/cmake-3.25.2-linux-x86_64.sh && \
    chmod +x cmake-3.25.2-linux-x86_64.sh && \
    ./cmake-3.25.2-linux-x86_64.sh --prefix=/usr/local --skip-license && \
    rm cmake-3.25.2-linux-x86_64.sh

# Install Python packages
RUN pip3 install --upgrade pip
COPY requirements.txt /tmp/
RUN pip3 install -r /tmp/requirements.txt && rm /tmp/requirements.txt

# Set up user (optional, for non-root usage)
# ARG USERNAME=codespace
# RUN useradd -m -s /bin/bash $USERNAME && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && chmod 0440 /etc/sudoers.d/$USERNAME
# USER $USERNAME

# Set working directory
WORKDIR /workspace

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
