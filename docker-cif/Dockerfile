#FROM python:3.6-alpine
FROM ssiaks-harbor-default.oit.duke.edu/cif/cif-base:2ea3158-1603974223
LABEL developer="Wes Young <wes@csirtgadgets.org>"
LABEL docker_maintainer="Drew Stinnett <drew.stinnett@duke.edu>"

ENV DOCKER_BUILD=yes
ENV LANG=C.UTF-8
ENV CIF_ANSIBLE_ES=localhost:9200
ENV CIF_ENABLE_INSTALL=1
ENV ARCHIVE_URL=https://github.com/csirtgadgets/bearded-avenger/archive

# Disable this once ready to deploy
# ENV CFLAGS="-O0"

VOLUME /usr/share/GeoIP

RUN mkdir -p /inactive_hunters && \
    wget https://raw.githubusercontent.com/JesseBowling/cifv3_scripts/master/logging_hunter.py -O /inactive_hunters/logging_hunter.py && \
    chmod 755 /inactive_hunters/logging_hunter.py && \
    mv /usr/local/lib/python3.6/site-packages/cif-*/cif/hunter/*.py /inactive_hunters/ && \
    mv /inactive_hunters/__init__.py /usr/local/lib/python3.6/site-packages/cif-*/cif/hunter/ && \
    chown -R cif /usr/local/lib/python3.6/site-packages/cif-*/cif/hunter/ && \
    chown -R cif /inactive_hunters && \
    rm -rf /tmp/bearded-avenger && \
    pip3 install Jinja2==2.11.2

COPY cif-helpers /cif-helpers
USER cif
ENTRYPOINT ["/cif-helpers/entrypoint-http"]
