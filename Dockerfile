# Based on the pre-built CircleCI PHP image.
# See https://circleci.com/docs/2.0/circleci-images/#php
FROM circleci/php:7.2.9-apache-stretch-node-browsers
LABEL maintainer="Johan Steen <artstorm@gmail.com>"

# Install Ruby
RUN sudo apt-get update \
    && sudo apt-get install -y \
        ruby ruby-dev \
    && sudo rm -rf /var/lib/apt/lists/*

# Install HTMLProofer
RUN sudo gem install html-proofer
