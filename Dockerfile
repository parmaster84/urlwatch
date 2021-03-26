FROM python:3.8.2

RUN apt-get update && apt-get install -y cronie
RUN python3 -m pip install --no-cache-dir pyyaml minidb requests keyring appdirs lxml cssselect beautifulsoup4 jsbeautifier cssbeautifier aioxmpp chump
RUN apt install cron -y

WORKDIR /opt/urlwatch

COPY lib ./lib
COPY share ./share
COPY setup.py .
COPY setup.cfg .

RUN python setup.py install

WORKDIR /root/.urlwatch

ENTRYPOINT ["urlwatch"]
