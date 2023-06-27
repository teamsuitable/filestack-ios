#!/usr/bin/env bash
set -o errexit #abort if any command fails

./bin/generate-docs.sh

GIT_DEPLOY_DIR=docs GIT_DEPLOY_BRANCH=gh-pages GIT_DEPLOY_REPO=git@github.com:filestack/filestack-ios.git ./bin/deploy-docs.sh
