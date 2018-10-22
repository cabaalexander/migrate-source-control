#!/bin/bash

trap "{ rm -rf $TEMP_DIR; }" SIGINT SIGTERM EXIT

__git_clone(){
  local SOURCE_CONTROL=$1
  local REPO=$2
  local FULL_PATH="git@${SOURCE_CONTROL}.com:cabaalexander/${REPO}.git"
  local DST="$SOURCE_CONTROL/$REPO"

  test -d $SOURCE_CONTROL || mkdir $SOURCE_CONTROL
  test -d $DST && return 0

  echo "Cloning: $REPO into '$DST'"
  echo
  git clone $FULL_PATH $DST &> /dev/null
}

URLS=(
  doom-arch-install
  jenkins-training
  dot-files
  nvim
  pdf
  devagrant
  learn-you-haskell
  hapi-server
  jenkins
  go-training
  gmail-api-getting-started
  getRandomFromArray
  anchat
)

__clone_repo(){
  for REPO in $@
  do
    __git_clone gitlab $REPO
  done
}

__clone_repo ${URLS[*]}

