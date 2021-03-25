FROM python:3.8.2

RUN apt-get update && apt-get install -y build-essential curl
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --no-cache-dir pyyaml minidb requests keyring appdirs lxml cssselect beautifulsoup4 jsbeautifier cssbeautifier aioxmpp

WORKDIR /opt/urlwatch

COPY lib ./lib
COPY share ./share
COPY setup.py .
COPY setup.cfg .

RUN python setup.py install

WORKDIR /root/.urlwatch

ENTRYPOINT ["urlwatch"]
