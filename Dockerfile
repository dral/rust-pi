FROM ubuntu:utopic

MAINTAINER Draltan Marin <draltan.marin@gmail.com>

RUN apt-get update && apt-get install -y \
	build-essential \
	clang \
	cmake \
	curl \
	git-core \
	libc6-dev-i386\
	libssl-dev \
	make \
	pkg-config \
	python

RUN git clone https://github.com/raspberrypi/tools.git --depth=1
RUN git clone http://github.com/mozilla/rust.git
RUN git clone https://github.com/rust-lang/cargo

ENV PI_TOOLS /tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin
ENV PATH $PI_TOOLS:$PATH
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/lib

RUN ln -s /tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/arm-linux-gnueabihf/bin/gcc /tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/arm-linux-gnueabihf/bin/cc

RUN apt-get update && apt-get install -y \
	gcc-4.9-multilib \
	g++-4.9-multilib

RUN cd /rust && ./configure --target=arm-unknown-linux-gnueabihf
RUN cd /rust && make
RUN cd /rust && make install
