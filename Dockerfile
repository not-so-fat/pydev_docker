FROM ubuntu:latest

WORKDIR /app

ENV SHELL=/bin/bash
RUN apt-get update \
    && apt-get install -y \
        g++ \
        make \
        bzip2 \
        wget \
        unzip \
        sudo \
        git \
        nkf \
        libpng-dev libfreetype6-dev \
        python3-dev \
        python3-pip

RUN pip3 install -U pip setuptools
RUN pip3 install wheel jupyter pytest twine

ADD ./requirements.txt /app/
RUN pip3 install -r /app/requirements.txt

ADD . /app

RUN python3 setup.py bdist_wheel sdist
RUN pip3 install dist/*.whl

EXPOSE 8888
CMD ["/bin/bash"]
