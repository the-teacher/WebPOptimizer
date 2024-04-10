# docker build -t iamteacher/image_optimizer -f dev/Dockerfile .
# docker run -it iamteacher/image_optimizer bash

FROM dpokidov/imagemagick:latest-bookworm

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# BASE DEPENDENCIES
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    wget curl \
    bash \
    jpegoptim libjpeg-dev libpng-dev libtiff-dev libgif-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "--login", "-c"]

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Install WEBP (dep: libjpeg-dev libpng-dev libtiff-dev libgif-dev)
# https://developers.google.com/speed/webp/download
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

WORKDIR /tmp

RUN wget -O libwebp-1.4.0-rc1-linux-x86-64.tar.gz https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.4.0-rc1-linux-x86-64.tar.gz
RUN tar -xvzf libwebp-1.4.0-rc1-linux-x86-64.tar.gz
RUN cp -R libwebp-1.4.0-rc1-linux-x86-64/bin/* /bin/

RUN rm -rf libwebp-1.4.0*

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# PNGQUANT (OLD C version)
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

WORKDIR /tmp

RUN wget -O pngquant-2.18.0.tar.gz https://pngquant.org/pngquant-2.18.0-src.tar.gz
RUN tar -xvzf pngquant-2.18.0.tar.gz
RUN cd pngquant-2.18.0 && \
    make install

RUN rm -rf pngquant-2.18*

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# NODE.JS (for SVGO)
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

ENV NVM_DIR="/opt/.nvm"
RUN mkdir /opt/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
RUN source /opt/.nvm/nvm.sh && nvm install 20.11.1

# Update NPM and Yarn versions
RUN npm install -g npm@10.5.0
RUN npm install -g yarn
RUN yarn set version berry

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# SVGO
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

RUN npm install -g svgo

WORKDIR /

CMD ["bash"]
ENTRYPOINT ["bash", "-l", "-c" ]
