FROM nginx:latest

# Install necessary packages to build Nginx with ngx_cache_purge
RUN apt-get update && \
    apt-get install -y build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev wget && \
    wget https://nginx.org/download/nginx-$(nginx -v 2>&1 | cut -d '/' -f 2).tar.gz && \
    tar -xzvf nginx-*.tar.gz && cd nginx-* && \
    wget https://github.com/FRiCKLE/ngx_cache_purge/archive/2.3.tar.gz && \
    tar -xzvf 2.3.tar.gz && \
    ./configure --add-module=ngx_cache_purge-2.3 && \
    make && make install && \
    rm -rf /var/lib/apt/lists/* /nginx-* /2.3.tar.gz

# Copy the custom Nginx binary over the default
RUN mv /usr/local/nginx/sbin/nginx /usr/sbin/nginx