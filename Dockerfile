FROM rustembedded/cross:arm-unknown-linux-gnueabihf-0.2.1

ENV PKG_CONFIG_ALLOW_CROSS 1
ENV INSIDE_DOCKER_CONTAINER 1

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        curl \
        git \
        pkg-config

RUN curl -O https://www.alsa-project.org/files/pub/lib/alsa-lib-1.2.4.tar.bz2 \
    && tar xvjf alsa-lib-1.2.4.tar.bz2 && cd alsa-lib-1.2.4 \
    && CC=arm-linux-gnueabihf-gcc ./configure --host=arm-linux-gnueabihf --disable-python \
    && make -j $(nproc --all) && make install \
    && cd .. && rm -rf alsa-lib-1.2.4.tar.bz2 alsa-lib-1.2.4

RUN mkdir /build