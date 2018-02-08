FROM ubuntu:16.04

RUN apt-get update &&\
    apt-get install -y libmicrohttpd-dev libssl-dev build-essential libhwloc-dev software-properties-common wget git cmake

RUN git clone https://github.com/fireice-uk/xmr-stak.git
RUN mkdir xmr-stak/build &&\
    cd xmr-stak/build &&\
    cmake -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF ..

RUN make install

COPY config.txt /xmt-stak/build/bin/
WORKDIR /xmr-stak/build/bin
 
CMD ./xmr-stak --noNVIDIA
