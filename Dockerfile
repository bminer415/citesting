FROM ubuntu:16.04

RUN apt-get update &&\
    apt-get install -y libmicrohttpd-dev libssl-dev build-essential libhwloc-dev software-properties-common

RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN apt-get update &&\
    apt-get install gcc-snapshot -y &&\
    apt-get update &&\
    apt-get install g++-6 -y
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6

ENV CMAKE_FILE=cmake-3.10.2-Linux-x86_64.sh
RUN wget --no-check-certificate https://cmake.org/files/v3.10/$CMAKE_FILE &&\
    chmod 755 $CMAKE_FILE &&\
    ./$CMAKE_FILE --skip-license --prefix=/usr

RUN git clone https://github.com/fireice-uk/xmr-stak.git
RUN mkdir xmr-stak/build &&\
    cd xmr-stak/build &&\
    cmake -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF ..

RUN make install

COPY config.txt /xmt-stak/build/bin/
WORKDIR /xmr-stak/build/bin
 
CMD ./xmr-stak --noNVIDIA
