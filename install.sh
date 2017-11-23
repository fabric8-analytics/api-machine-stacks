#!/usr/bin/env bash

set -eux;

INSTALL_PKGS="gcc highlight nss_wrapper gettext python34 python34-setuptools python34-devel openssl-devel libffi-devel";

# Setup necessary packages
useradd -u 1001 python_user
yum -y update
yum -y install epel-release 
yum -y groupinstall development
yum -y install ${INSTALL_PKGS} &&  yum clean all;
curl https://bootstrap.pypa.io/get-pip.py | python3.4 - 
python3 -m pip install -U pip
python3 -m pip install -r requirements.txt
python3 -m pip install -U gunicorn

# Fix the permissions
for item in "/app"; do
    . /opt/scripts/fix-permissions.sh ${item} 1001;
done
