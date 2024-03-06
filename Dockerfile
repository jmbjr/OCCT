# Use Ubuntu as the base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies including OpenGL libraries
RUN apt-get update && apt-get install -y \
    cmake \
    git \
    libfreetype6-dev \
    tcl-dev \
    tk-dev \
    build-essential \
    libx11-dev \
    libxmu-dev \
    libxi-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

# Clone OCCT from the official repository
WORKDIR /tmp
RUN git clone --depth 1 https://github.com/Open-Cascade-SAS/OCCT.git occt-src

# Create a build directory
WORKDIR /tmp/occt-build

# Configure the build with CMake
RUN cmake ../occt-src \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local

# Build and install
RUN make -j$(nproc) && make install

# Cleanup the build directory to reduce image size
RUN rm -rf /tmp/occt-src /tmp/occt-build

# Set the working directory to the install location
WORKDIR /usr/local

# This CMD can be overridden when running the container
CMD ["/bin/bash"]
