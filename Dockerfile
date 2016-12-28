FROM ruby:2.3-slim
# Docker images can start off with nothing, but it's extremely
# common to pull in from a base image. In our case we're pulling
# in from the slim version of the official Ruby 2.3 image.
#
# Details about this image can be found here:
# https://hub.docker.com/_/ruby/
#
# Slim is pulling in from the official Debian Jessie image.
#
# You can tell it's using Debian Jessie by clicking the
# Dockerfile link next to the 2.3-slim bullet on the Docker hub.
#
# The Docker hub is the standard place for you to find official
# Docker images. Think of it like GitHub but for Docker images.

MAINTAINER Yi <minsparky@gmail.com>
# It is good practice to set a maintainer for all of your Docker
# images. It's not necessary but it's a good habit.

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
build-essential nodejs libpq-dev git usbutils
# Ensure that our apt package list is updated and install a few
# packages to ensure that we can compile assets (nodejs) and
# communicate with PostgreSQL (libpq-dev).

RUN apt-get install -qq -y --no-install-recommends usbmuxd make automake autoconf libtool pkg-config gcc cython doxygen

RUN apt-get -y install libusbmuxd-dev libplist-dev libplist++-dev libssl-dev usbmuxd make automake autoconf libtool pkg-config gcc cython doxygen checkinstall libusb-1.0-0-dev libssl-dev python-dev python2.7-dev

ENV INSTALL_PATH /src
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
RUN git clone https://github.com/libimobiledevice/libplist.git \
  && cd /src/libplist \
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

