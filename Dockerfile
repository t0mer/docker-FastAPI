FROM ubuntu:20.04

LABEL maintainer="tomer.klein@gmail.com"

ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

RUN apt update -yqq

RUN apt install -yqq python3-pip && \
    apt install -yqq libffi-dev && \
    apt install -yqq libssl-dev

RUN pip3 install --upgrade pip setuptools  --no-cache-dir && \
    pip3 install loguru --no-cache-dir && \
    pip3 install requests --no-cache-dir && \
    pip3 install fastapi --no-cache-dir && \
    pip3 install uvicorn --no-cache-dir && \
    pip3 install jinja2 --no-cache-dir && \
    pip3 install aiofiles --no-cache-dir && \
    pip3 install python-multipart --no-cache-dir && \
    pip3 install starlette_exporter --no-cache-dir && \
    pip3 install cryptography==2.6.1 --no-cache-dir




  

