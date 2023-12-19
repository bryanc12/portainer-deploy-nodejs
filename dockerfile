FROM alpine:3.19.0

ARG GIT_REPO_URL

# Create app user and group
RUN addgroup -S app && adduser -S app -G app
# Create application folder and make app user owner of application directory
RUN mkdir -p /application && chown -R app:app /application
RUN chown -R app:app /home/app/.gitconfig

# Install dependencies
RUN apk update
RUN apk add libstdc++ git bash nodejs
RUN apk add --update npm

# Setup application
WORKDIR /application
RUN git clone ${GIT_REPO_URL} .
RUN git config credential.helper store
COPY ./run.sh /application/

# Switch to app user
# USER app

# Run application
CMD ["/bin/bash", "/application/run.sh"]