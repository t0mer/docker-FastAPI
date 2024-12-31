FROM ubuntu:24.10

LABEL maintainer="tomer.klein@gmail.com"

ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

RUN apt update -yqq

RUN apt install -yqq python3-pip && \
    apt install -yqq libffi-dev && \
    apt install -yqq libssl-dev


COPY requirements.txt /tmp

RUN pip3 install --upgrade pip setuptools  --no-cache-dir 

RUN pip3 install -r /tmp/requirements.txt



  

