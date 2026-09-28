*Please :star: this repo if you find it useful*

<p align="left"><br>
<a href="https://www.paypal.com/paypalme/techblogil?locale.x=he_IL" target="_blank"><img src="https://img.shields.io/badge/Donate-PayPal-blue.svg?logo=paypal" alt="PayPal"></a>
</p>

# docker-FastAPI

[![Docker Pulls](https://img.shields.io/docker/pulls/techblog/fastapi)](https://hub.docker.com/r/techblog/fastapi)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue)](License)

A base Docker image for running [FastAPI](https://fastapi.tiangolo.com/) web applications. It comes with Python, FastAPI, Uvicorn and a set of commonly used libraries already installed, so your own image only needs to add your code and any extra dependencies.

## Image versions

| Tag | Base | Status |
|-----|------|--------|
| `techblog/fastapi:latest`, `techblog/fastapi:3.0.0` | `ubuntu:20.04` (end of life) | Published on Docker Hub (December 2023) for `linux/amd64`, `linux/arm64` and `linux/arm/v7`. |
| `4.0.0` (current source) | `python:3.12-slim` | Not published, and does not build yet (see [Building the image](#building-the-image)). |

The current source in this repository (version `4.0.0`, see [`VERSION`](VERSION)) moved from Ubuntu 20.04 to `python:3.12-slim`. Until it is published, `latest` on Docker Hub is still the older Ubuntu-based `3.0.0` image (Python 3.8, FastAPI 0.104.1, Starlette 0.27.0). Older tags `1.0.0` to `2.0.0` also exist on Docker Hub.

## What's included (current source)

Python 3.12 plus the packages in [`requirements.txt`](requirements.txt):

| Package | Version | Purpose |
|---------|---------|---------|
| [FastAPI](https://fastapi.tiangolo.com/) | 0.115.0 | Web framework |
| [Uvicorn](https://uvicorn.dev/) | 0.30.6 | ASGI server |
| [Starlette](https://starlette.dev/) | ≥ 0.40.0 | ASGI toolkit used by FastAPI (conflicts with FastAPI 0.115.0, see below) |
| [Jinja2](https://jinja.palletsprojects.com/) | 3.1.4 | Templates |
| [aiofiles](https://pypi.org/project/aiofiles/) | 24.1.0 | Async file I/O |
| [python-multipart](https://pypi.org/project/python-multipart/) | 0.0.10 | Form and file-upload parsing |
| [loguru](https://loguru.readthedocs.io/) | 0.7.2 | Logging |
| [requests](https://requests.readthedocs.io/) | 2.32.3 | HTTP client |
| [starlette_exporter](https://github.com/stephenhillier/starlette_exporter) | ≥ 0.17.1 | Prometheus metrics middleware |
| [cryptography](https://cryptography.io/) | 46.0.5 | Cryptographic primitives |

The image also sets `PYTHONUNBUFFERED=1`, `PYTHONDONTWRITEBYTECODE=1`, `PIP_NO_CACHE_DIR=1`, `PIP_DISABLE_PIP_VERSION_CHECK=1`, `LANG=C.UTF-8` and `PYTHONIOENCODING=utf-8`, and installs `libffi-dev` and `libssl-dev`.

The image sets no `WORKDIR` or `EXPOSE` and no `CMD` of its own (the base image's default applies); your own Dockerfile sets those.

## Usage

Use the image as the base for your application's Dockerfile:

```dockerfile
FROM techblog/fastapi:latest

WORKDIR /opt/app

# Extra dependencies, if any
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080

CMD ["python3", "app.py"]
```

Here `app.py` starts Uvicorn itself, for example with `uvicorn.run(app, host="0.0.0.0", port=8080)`. You can also start Uvicorn directly:

```dockerfile
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8080"]
```

Use `python3` from the `PATH` rather than a fixed path such as `/usr/bin/python3`: that path exists in the Ubuntu-based `3.0.0` image but not in the `python:3.12-slim` based source.

## Building the image

```bash
git clone https://github.com/t0mer/docker-FastAPI.git
cd docker-FastAPI
docker build -t fastapi-base:local .
```

> **Known issue:** the build currently fails at the `pip install` step. `requirements.txt` pins `fastapi==0.115.0`, which requires `starlette<0.39.0`, but also asks for `starlette>=0.40.0`, so pip reports `ResolutionImpossible`. The requirements need to be reconciled before a 4.0.0 image can be built.

## Projects using this image

* [gotenberg-ui](https://github.com/t0mer/gotenberg-ui/blob/main/Dockerfile)
* [deepstack-trainer](https://github.com/t0mer/deepstack-trainer/blob/main/Dockerfile)

## CI

All workflows are started manually (`workflow_dispatch`); `docker-publish.yml` also runs when a GitHub release is published.

| Workflow | Publishes |
|----------|-----------|
| [`docker-publish.yml`](.github/workflows/docker-publish.yml) | Docker Hub, tagged `latest` and the value of `VERSION`, for amd64, arm64 and arm/v7 |
| [`publish-ghcr.yml`](.github/workflows/publish-ghcr.yml) | GitHub Container Registry (manual; no public image yet) |
| [`docker-jcr.yml`](.github/workflows/docker-jcr.yml) | A private JFrog registry |

## License

[Apache License 2.0](License)
