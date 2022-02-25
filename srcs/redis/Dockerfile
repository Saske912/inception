FROM debian:buster
RUN groupadd --gid=1156 redis
RUN useradd  -g redis --uid=156 redis
RUN apt-get -y update && apt-get install -y wget build-essential tcl
RUN wget http://download.redis.io/redis-stable.tar.gz && \
    tar xvzf redis-stable.tar.gz && cd redis-stable && make && make install
RUN mkdir /etc/redis
ADD conf/redis.conf /etc/redis
RUN chown root /etc/redis/redis.conf
CMD redis-server