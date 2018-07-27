FROM alpine:3.8

LABEL maintainer="Akrom Khasani <akrom@kofera.com>"

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Software version to install
ARG GOSU_VERSION=1.10

# Install additional package
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \ 
    apk add --no-cache bash curl py2-pip shadow@community

# Create users
ENV GENERAL_USER=user
RUN useradd -mU -d /home/${GENERAL_USER} ${GENERAL_USER} && passwd -d ${GENERAL_USER}
WORKDIR /home/${GENERAL_USER}

# Install cqlsh
RUN pip install -q --no-cache-dir --upgrade --upgrade-strategy=only-if-needed cqlsh

ADD ./cqlshrc /usr/local/
RUN mkdir -p /home/${GENERAL_USER}/.cassandra && \
    ln -sf /usr/local/cqlshrc /home/${GENERAL_USER}/.cassandra/cqlshrc

# Install gosu
RUN curl -skSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
        -o /usr/local/bin/gosu && \
    chmod a+x /usr/local/bin/gosu

ADD ./entrypoint.sh /usr/local/
RUN chmod a+x /usr/local/entrypoint.sh

ENTRYPOINT [ "/usr/local/entrypoint.sh" ]
