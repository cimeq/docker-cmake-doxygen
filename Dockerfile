FROM ubuntu:latest

# Update package list and install required packages
RUN apt-get update && apt-get install -y \
    cmake \
    doxygen \
    graphviz \
    python-is-python3 \
    python3-requests \
    git \
    build-essential \
    sshpass \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 111 cicd && \
    useradd -m -u 111 -g cicd cicd
USER cicd
WORKDIR /home/cicd

WORKDIR /project

ENV HOME=/home/cicd
