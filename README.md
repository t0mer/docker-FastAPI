*Please :star: this repo if you find it useful*

<p align="left"><br>
<a href="https://www.paypal.com/paypalme/techblogil?locale.x=he_IL" target="_blank"><img src="http://khrolenok.ru/support_paypal.png" alt="PayPal" width="250" height="48"></a>
</p>



# docker-FastAPI
[docker-FastAPI](https://github.com/t0mer/docker-FastAPI) Is ubuntu based image, created for running [FastAPI](https://fastapi.tiangolo.com/) based web applications ontop of docker container.

## Components and Libraries used in docker-FastAPI
* [FastAPI](https://fastapi.tiangolo.com/) - lightning-fast ASGI server implementation, using uvloop and httptools.
* [Uvicorn](https://www.uvicorn.org/) - lightning-fast ASGI server implementation, using uvloop and httptools. 
* [jinja](https://jinja.palletsprojects.com/en/3.0.x/) - fast, expressive, extensible templating engine.
* [aiofile](https://pypi.org/project/aiofile/) - Real asynchronous file operations with asyncio support.
* [loguru](https://loguru.readthedocs.io/en/stable/api/logger.html) - An object to dispatch logging messages to configured handlers.
* [python-multipart](https://pypi.org/project/python-multipart/) - A streaming multipart parser for Python
* [requests](https://docs.python-requests.org/en/latest/) - elegant and simple HTTP library for Python, built for human beings.


## How to use docker-FastAPI
Using docker-FastAPI is just easy like any other container. all you need to do is using the latest image, install your requirements and run you application. for example:

```
FROM techblog/fastapi:latest

RUN pip3 install -r requirements.txt

EXPOSE 8080

WORKDIR /opt/app/

ENTRYPOINT ["/usr/bin/python3", "app.py"]

```

## FastAPI usage sample
* [gotenberg-ui](https://github.com/t0mer/gotenberg-ui/blob/main/Dockerfile)
* [deepstack-traine](https://github.com/t0mer/deepstack-trainer/blob/main/Dockerfile)