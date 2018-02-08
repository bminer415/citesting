FROM ubuntu:16.04

RUN apt-get update &&\
    apt-get install -y libmicrohttpd-dev libssl-dev build-essential libhwloc-dev software-properties-common wget git cmake

RUN git clone https://github.com/fireice-uk/xmr-stak.git
WORKDIR /xmr-stak
RUN mkdir build &&\
    cd build &&\
    cmake -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF -DCPU_ENABLE=ON ..

COPY config.txt /xmt-stak/build/bin/
WORKDIR /xmr-stak/build/bin
 
RUN ls -la /
RUN ls -la /xmr-stak
RUN ls -la /xmr-stak/build/bin

CMD cd /xmr-stak/build/bin; ./xmr-stak --noNVIDIA
