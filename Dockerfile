FROM ubuntu:trusty
MAINTAINER "Brecht Machiels <brecht@mos6581.org>"

ENV poppler_version 0.62.0

RUN sudo apt-get -qq update
RUN sudo apt-get -yq --no-install-suggests --no-install-recommends --force-yes install \
    wget \
    xz-utils \
    build-essential \
    pkg-config \
    cmake3
   
# poppler dependencies
RUN sudo apt-get -yq --no-install-suggests --no-install-recommends --force-yes install \
    libfreetype6-dev \
    libfontconfig1-dev \
    libopenjpeg-dev \
    libjpeg-dev \
    libtiff-dev \
    libz-dev \
    liblcms2-dev \
    libcairo2-dev

WORKDIR /tmp
CMD /bin/bash -lc "\
	wget --no-check-certificate https://poppler.freedesktop.org/poppler-${poppler_version}.tar.xz ; \
	tar xf poppler-${poppler_version}.tar.xz ; \
	cd poppler-${poppler_version} ; \

    mkdir build ; \
    cd build ; \
    cmake .. \
        -DCMAKE_INSTALL_PREFIX=$HOME/.local \
        -DCMAKE_BUILD_TYPE=release \
        -DENABLE_QT5=OFF \
        -DENABLE_CPP=OFF \
        -DBUILD_CPP_TESTS=OFF \
        -DENABLE_GLIB=OFF \
        -DENABLE_UTILS=ON \
        -DENABLE_SPLASH=ON \
        -DENABLE_LIBOPENJPEG=unmaintained ; \
	make ; \
	make install ; \
	
	cd $HOME ; \
	tar cJf dotlocal.tar.xz .local ;"
