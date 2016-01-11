FROM        ubuntu:14.04

RUN apt-get update
RUN apt-get install -y python
RUN apt-get clean

ADD hello_world.py /tmp/hello_world.py

ENV HELLO_VERSION hello version 1

EXPOSE 80

ENTRYPOINT python -u /tmp/hello_world.py
