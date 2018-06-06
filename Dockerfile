FROM alpine:3.7
RUN apk add --no-cache py2-pip
RUN pip install --no-cache-dir --upgrade --upgrade-strategy=only-if-needed cqlsh
RUN mkdir -p /root/.cassandra
COPY ./cqlshrc /root/.cassandra/
