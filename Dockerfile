FROM registry.centos.org/centos/centos:7

RUN useradd machine
# Install deps for cryptography:
#  https://cryptography.io/en/latest/installation/#rhel-centos
RUN yum install -y gcc &&\
    yum install -y epel-release &&\
    yum install -y python34-pip &&\
    yum install -y redhat-rpm-config gcc libffi-devel httpd-devel python34-devel openssl-devel &&\
    yum clean all

RUN mkdir -p /machine
COPY ./ /machine
WORKDIR /machine
RUN pip3 install -r requirements.txt
CMD ["gunicorn", "app:app"]
