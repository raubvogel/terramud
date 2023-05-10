############################################################
# Dockerfile to build a terraform development instance 
# 
# 20230509
############################################################

# Set the base image to Ubuntu
FROM ubuntu:latest

# File Author / Maintainer.
# MAINTAINER is deprecated 
LABEL org.opencontainers.image.authors="raubvogel@gmail.com"

################## BEGIN INSTALLATION ######################

ENV DEVUSER mudbuilder
ENV DEVID 1995 
ENV EXTGID 1999

# Install all the packages we need
RUN apt-get update && apt-get -y upgrade 
RUN apt-get install -y \
  wget \
  gpg \
  python3-pip \
  vim git

# Get the terraform repo
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(cat /etc/os-release |grep UBUNTU_CODENAME|cut -d = -f 2) main" | tee /etc/apt/sources.list.d/hashicorp.list

RUN apt-get update 
RUN apt-get install -y terraform

##################### INSTALLATION END #####################

# Create user
RUN useradd -m --shell /bin/bash -u $DEVID $DEVUSER 

USER $DEVUSER
ENV WD /home/${DEVUSER}
WORKDIR ${WD}

RUN terraform -install-autocomplete
RUN pip3 install awscli --upgrade --user
ENV PATH="${WD}/.local/bin:${PATH}"

USER root

# Put the entrypoint script somewhere we can find
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod 0700 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

