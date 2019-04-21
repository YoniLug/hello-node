ARG NODE_VERSION=10.15.3-alpine
FROM node:10.15.3-alpine
MAINTAINER yonilugassi@gmail.com

LABEL git-commit=$GIT_COMMIT
LABEL Build-version=$BUILD_VERSION
LABEL Branch-name=$BRANCH_NAME

# Install Java, NPM & curl
RUN apk update && \
    apk add --no-cache wget openjdk8-jre-base curl

# Define path of the 'SRF_BROWSER_LAB_LOGS_DIR' directory (the remote-agent logs directory)
ENV LOGS_DIR=/var/log/app

# Create app directory, and 'SRF_BROWSER_LAB_LOGS_DIR' directory (the remote-agent logs directory)
RUN mkdir -p /opt/app && \
    mkdir -p $SRF_BROWSER_LAB_LOGS_DIR;

WORKDIR /opt/app
# Install app dependencies
COPY dist/ .
RUN npm set progress=false && \
    npm install --production --no-optional

EXPOSE 8080
CMD [ "node", "--max_old_space_size=280", "lib/app.js" ]
