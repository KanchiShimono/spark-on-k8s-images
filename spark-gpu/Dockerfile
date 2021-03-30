ARG base

FROM $base

ARG spark_uid=185

USER 0

# Reference
# https://gitlab.com/nvidia/container-images/cuda/-/tree/73b454d1723a6e3ed860aaad48c62d6b73afd80c/dist/11.0.3/ubuntu20.04-x86_64

# Base

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    gnupg2 && \
  curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub | apt-key add - && \
  echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
  echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
  rm -rf /var/cache/apt/* && \
  rm -rf /var/lib/apt/lists/*

ENV CUDA_VERSION 11.0.3

RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    cuda-cudart-11-0=11.0.221-1 \
    cuda-compat-11-0 && \
  ln -s cuda-11.0 /usr/local/cuda && \
  rm -rf /var/cache/apt/* && \
  rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
  echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.0 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 brand=tesla,driver>=450,driver<451"


# Runtime
ENV NCCL_VERSION 2.8.4

RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    cuda-libraries-11-0=11.0.3-1 \
    libnpp-11-0=11.1.0.245-1 \
    cuda-nvtx-11-0=11.0.167-1 \
    libcublas-11-0=11.2.0.252-1 \
    libcusparse-11-0=11.1.1.245-1 \
    libnccl2=$NCCL_VERSION-1+cuda11.0 && \
  rm -rf /var/cache/apt/* && \
  rm -rf /var/lib/apt/lists/*

# apt from auto upgrading the cublas package. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
RUN apt-mark hold libcublas-11-0 libnccl2


# CUDNN
ENV CUDNN_VERSION 8.0.5.39

RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    libcudnn8=$CUDNN_VERSION-1+cuda11.0 && \
  apt-mark hold libcudnn8 && \
  rm -rf /var/cache/apt/* && \
  rm -rf /var/lib/apt/lists/*

# TODO: Install TensorRT in the future
# TensorRT is not available for Ubuntu 20.04
# Fortunately Tensorflow request TensorRT as optional dependency

USER ${spark_uid}
