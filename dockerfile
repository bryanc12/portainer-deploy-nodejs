FROM alpine:3.19.0

ARG GIT_REPO_URL

ENV NODE_PACKAGE_URL https://nodejs.org/dist/v20.10.0/node-v20.10.0-linux-arm64.tar.gz

# Install dependencies
RUN apk update
RUN apk add libstdc++ git bash

# Install Node.js
WORKDIR /opt
RUN wget $NODE_PACKAGE_URL
RUN mkdir -p /opt/nodejs
RUN tar -zxvf *.tar.gz --directory /opt/nodejs --strip-components=1
RUN rm *.tar.gz
RUN ln -s /opt/nodejs/bin/node /usr/local/bin/node
RUN ln -s /opt/nodejs/bin/npm /usr/local/bin/npm

# Get the application from git
WORKDIR /application
RUN git clone ${GIT_REPO_URL} .
COPY ./run.sh /application/run.sh

CMD ["/bin/bash", "/application/run.sh"]