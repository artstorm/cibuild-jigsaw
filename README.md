# Jigsaw Docker CI Build

A Docker image for [Jigsaw](https://github.com/tightenco/jigsaw), static site generator based on Laravel. The image includes [HTMLProofer](https://github.com/gjtorikian/html-proofer) to test the build. Hosted on [Docker Hub](https://hub.docker.com/r/artstorm/cibuild-jigsaw/).

The image is based on the pre-built [CircleCI PHP image](https://circleci.com/docs/2.0/circleci-images/#php), with the additions of Ruby and HTMLProofer to make it suitable for building and testing Jigsaw generated websites.

## Usage Example

Use this `.circleci/config.yml` example config to get started building and testing Jigsaw websites with CircleCI.

```yml
##
## CircleCI 2.0 configuration file
##
version: 2
jobs:
  build:
    docker:
      - image: artstorm/cibuild-jigsaw:latest

    working_directory: ~/repo

    steps:
      - checkout

      # Download and cache composer dependencies
      - restore_cache:
          keys:
          - composer-cache-{{ checksum "composer.lock" }}
      - run: composer install -n --prefer-dist
      - save_cache:
          key: composer-cache-{{ checksum "composer.lock" }}
          paths:
            - vendor

      # Download and cache node dependencies
      - restore_cache:
          keys:
            - npm-cache-{{ checksum "package-lock.json" }}
      - run: npm install
      - save_cache:
          key: npm-cache-{{ checksum "package-lock.json" }}
          paths:
            - node_modules

      # Build site
      - run:
          name: Build
          command: npm run production

      # And test it
      - run:
          name: Test
          command: htmlproofer ./build_production --check-html --disable-external --check-img-http --check-opengraph
```
