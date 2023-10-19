# syntax=docker/dockerfile:1

# repo=bthornton191/adams_build0:2022_1-rl8.4
FROM docker.io/rockylinux/rockylinux:8.4 AS rl8
LABEL maintainer=ben.thornton@hexagon.com

# ==================================================================================================
# Install dependencies
# ==================================================================================================
RUN dnf -y update
RUN dnf install -y fontconfig-devel libpng libXext libXrender libSM libstdc++ unzip mesa-libGL mesa-libGLU net-tools
RUN dnf install -y freeglut 
RUN dnf install -y xorg-x11-server-Xvfb 
RUN dnf install -y csh
RUN dnf install -y gcc
RUN dnf clean all

# ==================================================================================================
# TODO: Setup c++ Compiler (Not yet working)
# ==================================================================================================
# ------------------------------------------
# OPTION 1: Install Intel Parallel Studio XE
# ------------------------------------------
# RUN rpm --import https://yum.repos.intel.com/2020/setup/RPM-GPG-KEY-intel-psxe-runtime-2020
# RUN rpm -Uhv https://yum.repos.intel.com/2020/setup/intel-psxe-runtime-2020-reposetup-1-0.noarch.rpm
# RUN yum -y install intel-psxe-runtime-2020.4
# RUN yum -y install intel-icc-runtime*

# ------------------------------
# OPTION 2: Install Intel oneAPI
# ------------------------------
# RUN tee > /tmp/oneAPI.repo << EOF \
#     [oneAPI] \
#     name=Intel® oneAPI repository \
#     baseurl=https://yum.repos.intel.com/oneapi \
#     enabled=1 \
#     gpgcheck=1 \
#     repo_gpgcheck=1 \
#     gpgkey=https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
#     EOF
# RUN mv /tmp/oneAPI.repo /etc/yum.repos.d
# RUN yum install -y intel-basekit
# RUN yum -y update
# RUN yum -y install cmake pkgconfig
# RUN yum -y groupinstall "Development Tools"
# ==================================================================================================


WORKDIR /
COPY installers installers
WORKDIR /installers

# ==================================================================================================
# Install Adams
# ==================================================================================================
RUN mkdir /Adams
RUN mkdir /Adams/2022_1

ENV FLEXLM_TIMEOUT 5000000
ENV MSC_OS_PREF rhe79


# ==================================================================================================
# After building...
# ==================================================================================================
# - Run interactively using `docker run -it --name adams_build1 bthornton191/adams_build0:2022_1-rl8.4 /bin/bash`
# - Manually install Adams
# - commit container to bthornton191/adams_build1:2022_1-rl8.4
# - run build linux_final/Dockerfile
# ==================================================================================================
