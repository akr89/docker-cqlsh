FROM volantis/debian:stretch

RUN apt-get-install python-pip && \
    pip install --no-cache-dir --upgrade --upgrade-strategy=only-if-needed setuptools && \
    pip install --no-cache-dir --upgrade --upgrade-strategy=only-if-needed cqlsh

ADD ./cqlshrc /usr/local/
RUN mkdir -p /root/.cassandra /home/${DEFAULT_USER}/.cassandra && \
    ln -sf /usr/local/cqlshrc /root/.cassandra/cqlshrc && \
    ln -sf /usr/local/cqlshrc /home/${DEFAULT_USER}/.cassandra/cqlshrc
