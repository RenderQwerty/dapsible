FROM docker:stable
LABEL maintainer "Yurii Fisakov <fisakov.root@gmail.com>"
ENV ANSIBLE="ansible==2.6.3"
ENV PACKER_VERSION=1.2.5 \
    PACKER_OSARCH=amd64 \
    PACKER_OSNAME=linux \
    PACKER_DEST=/bin

ENV PACKER_ZIPFILE=packer_${PACKER_VERSION}_${PACKER_OSNAME}_${PACKER_OSARCH}.zip

RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/${PACKER_ZIPFILE} -O ${PACKER_DEST}/packer.zip && \
    unzip ${PACKER_DEST}/packer.zip -d ${PACKER_DEST} && \
    rm -rf ${PACKER_DEST}/packer.zip

RUN apk --no-cache add \
    sudo \
    python \
    py-pip \
    openssl \
    ca-certificates

RUN apk --no-cache add --virtual \
    build-dependecies \
    python-dev \
    libffi-dev \
    openssl-dev \
    build-base

RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache --upgrade cffi ${ANSIBLE}
