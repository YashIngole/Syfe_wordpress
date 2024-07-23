FROM ubuntu:20.04

ENV OPENRESTY_VERSION=1.19.3.1

RUN apt-get update && apt-get install -y \
    build-essential \
    libpcre3-dev \
    libssl-dev \
    zlib1g-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN wget https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz \
    && tar -xzvf openresty-${OPENRESTY_VERSION}.tar.gz \
    && cd openresty-${OPENRESTY_VERSION} \
    && ./configure --prefix=/opt/openresty \
        --with-pcre-jit \
        --with-ipv6 \
        --without-http_redis2_module \
        --with-http_iconv_module \
        --with-http_postgres_module \
        -j8 \
    && make -j8 \
    && make install \
    && cd /tmp \
    && rm -rf openresty-${OPENRESTY_VERSION}*

ENV PATH=$PATH:/opt/openresty/nginx/sbin

COPY nginx.conf /opt/openresty/nginx/conf/nginx.conf

EXPOSE 80

CMD ["/opt/openresty/nginx/sbin/nginx", "-g", "daemon off;"]