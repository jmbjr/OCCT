# Use Ubuntu as the base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    libfreetype6-dev \
    tcl-dev \
    tk-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /github/workspace

# The ENTRYPOINT or CMD that runs the build commands can be customized as needed.
# For simplicity, we're using a shell form here.
CMD ["sh", "-c", "mkdir build && cd build && cmake .. -DCMAKE_BUILD_TYPE=Release && make -j2"]
