FROM python:3.8.2

RUN apt-get update && apt-get install -y cron bash wget
#CMD [ "cron", "-f" ]

RUN python3 -m pip install --no-cache-dir pyyaml minidb requests keyring appdirs lxml cssselect beautifulsoup4 jsbeautifier cssbeautifier aioxmpp chump

WORKDIR /opt/urlwatch

COPY lib ./lib
COPY share ./share
COPY setup.py .
COPY setup.cfg .

RUN python setup.py install

RUN echo '*/30 * * * * cd /root/.urlwatch && urlwatch --urls urls.yaml --config urlwatch.yaml --hooks hooks.py --cache cache.db' | crontab -

VOLUME /root/.urlwatch
WORKDIR /root/.urlwatch

#ENTRYPOINT ["urlwatch"]
#CMD [ "cron", "-f" ]
CMD ["cron", "-f", "-L", "/dev/stdout"]
