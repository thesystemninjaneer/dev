# Description:
#   This Dockerfile is from https://github.com/thesystemninjaneer/dev.git and
#   includes the base tools needed for developing infrastructure as code
#   resources.
#
#   Ex:  docker run -ti -v "$HOME/code:/root/code" -v "$HOME/.aws:/root/.aws" thesystemninjaneer:dev bash
# Author: thesystemninjaneer@gmail.com
# Date: 1/1/2020

FROM centos:8
LABEL maintainer="thesystemninjaneer@gmail.com"

# Install GCP CLI based on https://cloud.google.com/sdk/docs/
ENV GPC_RPM_URL https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
RUN yum install -y dnf-utils && \
    yum-config-manager --add-repo $GPC_RPM_URL && \
    reponame=$(echo ${GPC_RPM_URL##http[s]://} | tr '/' '_') && \
    yum-config-manager --save --setopt=$repoid.gpgkey='https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg' && \
    yum -y install google-cloud-sdk

# Freshen up base image and install ansible, kubectl
RUN yum -y update && \
    yum install -y git zip epel-release python3-pip dnf-utils tmux wget && \
    yum install -y ansible kubectl

# Install AWS CLI based on https://github.com/aws/aws-cli#installation
RUN pip3 install --user awscli
ENV PATH $PATH:/root/.local/bin

# Install HashiCorp terraform
RUN tf_ver=$(curl -s -k https://www.terraform.io/downloads.html|grep Linux -A3|grep 64-bit|cut -d\" -f2) && \
    curl -s -O -k $tf_ver && \
    unzip terraform_*.zip -d /usr/local/sbin/

# Cleanup
RUN yum clean all
WORKDIR /root
