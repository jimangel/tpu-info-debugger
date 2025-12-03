# Use a Python 3.12 slim image, which is based on Debian and includes apt
FROM python:3.12-slim-bookworm

# Install git, which is required by pip to install directly from a git repository
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

# Install tpu-info from the GitHub source
RUN python3 -m pip install --no-cache-dir --upgrade git+https://github.com/google/cloud-accelerator-diagnostics/#subdirectory=tpu_info

# Set a working directory
WORKDIR /app

# No ENTRYPOINT or CMD is needed, as we will run commands manually via kubectl debug
