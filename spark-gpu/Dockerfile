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

ENV CUDA_VERSION 11.2.2

RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    cuda-cudart-11-2=11.2.152-1 \
    cuda-compat-11-2 && \
  ln -s cuda-11.2 /usr/local/cuda && \
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
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.2 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 driver>=450,driver<451"


# Runtime
ENV NCCL_VERSION 2.8.4

RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    cuda-libraries-11-2=11.2.2-1 \
    libnpp-11-2=11.3.2.152-1 \
    cuda-nvtx-11-2=11.2.152-1 \
    libcublas-11-2=11.4.1.1043-1 \
    libcusparse-11-2=11.4.1.1152-1 \
    libnccl2=$NCCL_VERSION-1+cuda11.2 && \
  rm -rf /var/cache/apt/* && \
  rm -rf /var/lib/apt/lists/*

# apt from auto upgrading the cublas package. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
RUN apt-mark hold libcublas-11-2 libnccl2


# Cudnn
ENV CUDNN_VERSION 8.1.1.33

RUN set -eux; \
  apt update && \
  apt install -y --no-install-recommends \
    libcudnn8=$CUDNN_VERSION-1+cuda11.2 && \
  apt-mark hold libcudnn8 && \
  rm -rf /var/cache/apt/* && \
  rm -rf /var/lib/apt/lists/*

USER ${spark_uid}
