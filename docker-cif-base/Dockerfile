#FROM python:3.6-alpine
FROM python:3.6.8-alpine3.8
LABEL developer="Wes Young <wes@csirtgadgets.org>"
LABEL docker_maintainer="Drew Stinnett <drew.stinnett@duke.edu>"

ARG CIF_TAG="tags/3.0.9"

ENV DOCKER_BUILD=yes
ENV LANG=C.UTF-8
ENV CIF_ANSIBLE_ES=localhost:9200
ENV CIF_ENABLE_INSTALL=1
ENV ARCHIVE_URL=https://github.com/csirtgadgets/bearded-avenger/archive

# Disable this once ready to deploy
# ENV CFLAGS="-O0"

VOLUME /usr/share/GeoIP

# hadolint ignore=DL3018,DL3003
RUN apk --no-cache add  \
        shadow g++ make python3-dev shadow libxml2-dev libxslt-dev \
        bash libffi-dev openssl-dev wget geoip curl git libmagic && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/log/cif \
             /var/log/gunicorn \
             /var/lib/cif \
             /var/run/cif \
             /var/run/smrt \
             /var/lib/smrt \
             /etc/cif \
             /home/cif && \
    useradd -m -s /bin/bash cif && \
    touch /home/cif/.profile \
          /home/cif/.cif.yml && \
    chown -R cif /home/cif \
                 /etc/cif \
                 /var/log/gunicorn \
                 /var/run/smrt \
                 /var/lib/smrt \
                 /var/log/cif \
                 /var/lib/cif \
                 /var/run/cif && \
    git clone https://github.com/csirtgadgets/bearded-avenger.git /tmp/bearded-avenger && \
    git -C /tmp/bearded-avenger checkout "${CIF_TAG}" && \
    pip3 install --upgrade --no-cache-dir pip==20.2.3 && \
    pip3 install --upgrade --no-cache-dir requests==2.22.0 && \
    pip3 install --upgrade --no-cache-dir python-magic==0.4.18 && \
    pip3 install --no-cache-dir -r /tmp/bearded-avenger/dev_requirements.txt && \
    cd /tmp/bearded-avenger && \
    python3 ./setup.py install
