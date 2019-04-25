FROM docker:stable
LABEL maintainer="Yurii Fisakov <fisakov.root@gmail.com>"
ENV PACKER_VERSION=1.4.0 \
    PACKER_OSARCH=amd64 \
    PACKER_OSNAME=linux \
    PACKER_DEST=/bin
ENV PACKER_ZIPFILE=packer_${PACKER_VERSION}_${PACKER_OSNAME}_${PACKER_OSARCH}.zip

RUN apk --no-cache add \
    sudo \
    python3 \
    openssl \
    ca-certificates \
    less \
    openssh-client \
    p7zip \
    py-lxml \
    rsync \
    sshpass \
    jq \
    curl

RUN curl -o ${PACKER_DEST}/packer.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/${PACKER_ZIPFILE} && \
    unzip ${PACKER_DEST}/packer.zip -d ${PACKER_DEST} && \
    rm -rf ${PACKER_DEST}/packer.zip

RUN apk --no-cache add --virtual \
    build-dependecies \
    python3-dev \
    libffi-dev \
    openssl-dev \
    build-base

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    rm -f get-pip.py

COPY requirements.txt /

RUN pip3 install --no-cache --upgrade -r /requirements.txt
