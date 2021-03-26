FROM python:3.8.2

RUN apt-get update && apt-get install -y cron bash wget

RUN python3 -m pip install --no-cache-dir pyyaml minidb requests keyring appdirs lxml cssselect beautifulsoup4 jsbeautifier cssbeautifier aioxmpp chump

WORKDIR /opt/urlwatch

COPY lib ./lib
COPY share ./share
COPY setup.py .
COPY setup.cfg .

RUN python setup.py install

#RUN touch /var/spool/cron/crontabs/root
#RUN echo '*/1 * * * * cd /root/.urlwatch && urlwatch --urls urls.yaml --config urlwatch.yaml --hooks hooks.py --cache cache.db' | crontab -
#RUN crontab /var/spool/cron/crontabs/root

COPY crontab /var/spool/cron/crontabs/root
RUN chmod 0644 /var/spool/cron/crontabs/root
RUN crontab /var/spool/cron/crontabs/root


VOLUME /root/.urlwatch
WORKDIR /root/.urlwatch

#ENTRYPOINT ["urlwatch"]
#CMD ["cron", "-f", "-L", "/dev/stdout"]
CMD [ "cron", "-f" ]

