FROM ubuntu:20.04 AS codeql_base
LABEL maintainer="Github codeql team"

# tzdata install needs to be non-interactive
ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=codeql
ENV CODEQL_HOME /usr/local/codeql-home

# create user, install/update basics and python
RUN adduser --home ${CODEQL_HOME} ${USERNAME} && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    	software-properties-common \
    	vim \
    	curl \
    	wget \
    	git \
    	build-essential \
    	unzip \
    	apt-transport-https \
        python3.8 \
    	python3-venv \
    	python3-pip \
    	python3-setuptools \
        python3-dev \
    	gnupg \
    	g++ \
    	make \
    	gcc \
    	apt-utils \
        rsync \
    	file \
        nodejs \
        dos2unix \
    	gettext && \
        apt-get clean && \
        rm -f /usr/bin/python /usr/bin/pip && \
        ln -s /usr/bin/python3.8 /usr/bin/python && \
        ln -s /usr/bin/pip3 /usr/bin/pip 

ENV PYTHONIOENCODING=utf-8

USER ${USERNAME}

ENTRYPOINT ["python3", "/usr/local/startup_scripts/startup.py"]
