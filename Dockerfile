FROM debian
MAINTAINER Sven Hecht <sven@fablab-karlsruhe.de>

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y build-essential wget git gcc-multilib rpm libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386

ADD . /src

WORKDIR /src

RUN ./linux_install

# remove last line
RUN sed -i '$ d' BuildShell


CMD export LPC_DEPLOY='cp PROJECT.bin /media/MBED/ ; sync' && export PATH=/src/gcc-arm-none-eabi/bin:$PATH && make clean && make all