FROM ubuntu:22.04

WORKDIR /app

ENV USERNAME=neo
RUN useradd -ms /bin/bash ${USERNAME}
RUN usermod -aG sudo ${USERNAME}

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
        python3-pip \
        python3-venv

RUN pip3 install -U pip setuptools virtualenv
RUN chown -R ${USERNAME} /app

USER ${USERNAME}
ENV PATH=/app/venv/bin:$PATH
RUN python3 -m venv venv && chmod 700 ./venv/bin/activate
RUN /app/venv/bin/pip install wheel jupyter pytest twine
RUN venv/bin/jupyter labextension disable "@jupyterlab/apputils-extension:announcements"

# ^ common requirements

ADD ./requirements.txt /app/requirements.txt
RUN /app/venv/bin/pip install -r /app/requirements.txt

# ^ module dependency

ADD --chown=${USERNAME}:${USERNAME} . /app
RUN /app/venv/bin/python setup.py bdist_wheel sdist
RUN /app/venv/bin/pip install dist/*.whl

# ^ update of module itself / test codes

EXPOSE 5000
EXPOSE 8888
CMD ["venv/bin/jupyter", "notebook", "--ip", "0.0.0.0", "--no-browser", "--NotebookApp.token=''"]
