FROM ubuntu:latest

ENV DOXYGEN_VERSION=Release_1_14_0
ENV DOXYGEN_FOLDER_VERSION=1.14.0
ENV DOXYGEN_FILE_NAME=doxygen-1.14.0.src.tar.gz
# Update package list and install required packages
RUN apt-get update && apt-get install -y \
    cmake \
    graphviz \
    python-is-python3 \
    python3-requests \
    git \
    build-essential \
    sshpass \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/*
RUN apt update && apt install flex bison -y

# Install additional packages
RUN apt update && apt install llvm-19-dev libclang-19-dev gcovr clang-tidy-19 -y

# Install latest Doxygen from source
RUN apt-get install -y \
    libedit-dev \
    zlib1g-dev \
    libzstd-dev \
    curl libssl-dev libcurl4-openssl-dev \
    qt6-base-dev qt6-tools-dev qt6-tools-dev-tools

RUN cd /tmp && \
    wget https://github.com/doxygen/doxygen/releases/download/${DOXYGEN_VERSION}/${DOXYGEN_FILE_NAME} && \
    tar -xzf ${DOXYGEN_FILE_NAME}
RUN ls .
WORKDIR /tmp/doxygen-${DOXYGEN_FOLDER_VERSION}
RUN cmake -B build \
          -Dbuild_wizard=YES \
          -Dbuild_parse=YES \
          -Duse_libclang=YES \
          -DCMAKE_BUILD_TYPE=Release

RUN cmake --build build -j$(nproc)
RUN cd build && make install
RUN cd /tmp && \
    rm -rf doxygen-${DOXYGEN_FOLDER_VERSION}*

RUN groupadd -g 111 cicd && \
    useradd -m -u 111 -g cicd cicd
USER cicd
WORKDIR /home/cicd

WORKDIR /project

ENV HOME=/home/cicd
