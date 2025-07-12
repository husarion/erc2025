FROM python:3.12-bookworm

ARG DEBIAN_FRONTEND=noninteractive

# Install ansible & ansible-lint
RUN apt-get update && apt-get -y install python3-pip openssh-client sudo
RUN pip3 install pip --upgrade
RUN pip3 install "ansible==9.1" "ansible-lint[community,yamllint]" "netaddr"

WORKDIR /workdir
