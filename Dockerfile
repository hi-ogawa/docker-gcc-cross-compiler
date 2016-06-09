FROM ubuntu:14.04

RUN apt-get update && apt-get install -y gcc wget build-essential

# specify binutils/gcc version
ENV DOWNLOAD_BINUTILS=binutils-2.26
ENV DOWNLOAD_GCC=gcc-4.9.3

# download binutils/gcc and its dependencies
RUN wget -q http://ftp.gnu.org/gnu/binutils/$DOWNLOAD_BINUTILS.tar.gz
RUN tar -xzf $DOWNLOAD_BINUTILS.tar.gz

RUN wget -q ftp://ftp.gnu.org/gnu/gcc/$DOWNLOAD_GCC/$DOWNLOAD_GCC.tar.gz
RUN tar -xzf $DOWNLOAD_GCC.tar.gz

RUN cd /$DOWNLOAD_GCC && contrib/download_prerequisites

# specify TARGET
ENV TARGET=i686-elf
ENV PREFIX=/usr/local

# build binutils
RUN mkdir -p /srv/build_binutils
WORKDIR /srv/build_binutils
RUN /$DOWNLOAD_BINUTILS/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
RUN make
RUN make install

# build gcc
RUN mkdir -p /srv/build_gcc
WORKDIR /srv/build_gcc
RUN /$DOWNLOAD_GCC/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
RUN make all-gcc
RUN make all-target-libgcc
RUN make install-gcc
RUN make install-target-libgcc

# remove big files
RUN rm -r /$DOWNLOAD_BINUTILS /$DOWNLOAD_GCC /srv/build_binutils /srv/build_gcc

WORKDIR /
