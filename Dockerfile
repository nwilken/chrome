FROM amazonlinux:2
LABEL maintainer="Nate Wilken <wilken@asu.edu>"

COPY google-chrome.repo /etc/yum.repos.d/

RUN curl --silent --location https://rpm.nodesource.com/setup_14.x | bash - && \
    yum update -y && \
    yum install -y google-chrome-stable nodejs tar && \
    yum clean all && \
    rm -rf /var/cache/yum

WORKDIR /opt/test
COPY karma.conf.js .

RUN adduser -U testuser && \
    mkdir ./screenshots && \
    chown -R testuser:testuser .

USER testuser

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/google-chrome

RUN npm install --save-dev puppeteer jest jest-puppeteer karma karma-chrome-launcher karma-mocha karma-chai mocha chai minimist
