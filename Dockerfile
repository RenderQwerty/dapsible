FROM docker:stable
LABEL maintainer "Yurii Fisakov <fisakov.root@gmail.com>"
ENV PACKER_VERSION=1.2.5 \
    PACKER_OSARCH=amd64 \
    PACKER_OSNAME=linux \
    PACKER_DEST=/bin

ENV PACKER_ZIPFILE=packer_${PACKER_VERSION}_${PACKER_OSNAME}_${PACKER_OSARCH}.zip

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/${PACKER_ZIPFILE} ${PACKER_DEST}/
RUN unzip ${PACKER_DEST}/${PACKER_ZIPFILE} -d ${PACKER_DEST} && \
    rm -rf ${PACKER_DEST}/${PACKER_ZIPFILE}
