#!/bin/bash
git clone -b  $BRANCH $GIT_URL docs
cd docs
gitbook serve
