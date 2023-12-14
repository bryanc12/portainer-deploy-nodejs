FROM alpine:3.19.0

ARG GIT_REPO_URL

# Install dependencies
RUN apk update
RUN apk add libstdc++ git bash nodejs
RUN apk add --update npm

# Setup application
WORKDIR /application
RUN git clone ${GIT_REPO_URL} .
RUN git config credential.helper store
COPY ./run.sh /application/

# Run application
CMD ["/bin/bash", "/application/run.sh"]