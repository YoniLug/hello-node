ARG NODE_VERSION=10.15.3-alpine
FROM node:10.15.3-alpine
MAINTAINER yonilugassi@gmail.com

LABEL GIT_COMMIT=$GIT_COMMIT
LABEL BUILD_VERSION=$BUILD_VERSION
LABEL BRANCH_NAME=$BRANCH_NAME

# Create app directory
RUN mkdir -p /opt/app 
WORKDIR /opt/app

# Install app dependencies
COPY dist/ .
RUN npm set progress=false && \
    npm install --production --no-optional

EXPOSE 8080
CMD [ "node","app/app.min.js" ]
