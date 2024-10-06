FROM debian:testing-slim
# Slim is pulling in from the official Debian Jessie image.
#
# You can tell it's using Debian Jessie by clicking the
# Dockerfile link next to the 2.3-slim bullet on the Docker hub.
#
# The Docker hub is the standard place for you to find official
# Docker images. Think of it like GitHub but for Docker images.

MAINTAINER Tom <tpmullan@gmail.com>
# It is good practice to set a maintainer for all of your Docker
# images. It's not necessary but it's a good habit.

RUN apt-get update && apt-get install -qq -y \
  autoconf \
  automake \
  build-essential \
  checkinstall \
  ca-certificates \
  cython3 \
  python3 \
  python3-dev \
  python3-pip \
  python3-setuptools \
  doxygen \
  git \
  libcurl4 \
  libcurl4-openssl-dev \
  libssl-dev \
  libffi-dev \
  libtool-bin \
  pkg-config \
  usbmuxd

ENV INSTALL_PATH /src
RUN mkdir -p $INSTALL_PATH

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

WORKDIR $INSTALL_PATH
RUN git clone https://github.com/libimobiledevice/libplist.git \
  && cd /src/libplist \
  && ./autogen.sh \
  && make \
  && make install

WORKDIR $INSTALL_PATH
RUN git clone https://github.com/libimobiledevice/libtatsu.git \
  && cd /src/libtatsu \
  && ./autogen.sh \
  && make \
  && make install

WORKDIR $INSTALL_PATH
RUN git clone https://github.com/libimobiledevice/libimobiledevice-glue.git \
  && cd /src/libimobiledevice-glue \
  && ./autogen.sh \
  && make \
  && make install

WORKDIR $INSTALL_PATH
RUN git clone https://github.com/libimobiledevice/libusbmuxd.git \
  && cd /src/libusbmuxd \
  && ./autogen.sh \
  && make \
  && make install

WORKDIR $INSTALL_PATH
RUN git clone https://github.com/libimobiledevice/libimobiledevice.git \
  && cd /src/libimobiledevice \
  && ./autogen.sh \
  && make \
  && make install

RUN apt-get -y install ideviceinstaller

CMD cd

