FROM levkov/base:latest
MAINTAINER levkov

RUN apt-get update &&\
    apt-get install -y build-essential g++ curl libssl-dev apache2-utils git libxml2-dev sshfs wget nodejs nodejs-legacy npm && \
    git clone https://github.com/c9/core.git /cloud9 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

WORKDIR /cloud9
RUN scripts/install-sdk.sh && \
    sed -i -e 's_127.0.0.1_0.0.0.0_g' /cloud9/configs/standalone.js && \
    mkdir /workspace


ADD conf/cloud9.conf /etc/supervisor/conf.d/

EXPOSE 80
