#!/bin/bash

trap "{ rm -rf $TEMP_DIR; }" SIGINT SIGTERM EXIT

__make_git_url(){
  local SOURCE_CONTROL=$1
  local REPO=$2
  echo "git@${SOURCE_CONTROL}.com:cabaalexander/${REPO}.git"
}

REPO_NAMES=(
  devagrant
  doom-arch-install
  dot-files
  getRandomFromArray
  gmail-api-getting-started
  go-training
  hapi-server
  jenkins
  jenkins-training
  learn-you-haskell
  migrate-source-control
  nvim
  pdf
)

SRC=${1:-"gitlab"}
DST=${2:-"github"}

__clone_repos(){
  # Clone all repos from source
  # ===========================
  for REPO in ${REPO_NAMES[*]}
  do
    local DST="$SRC/$REPO"

    test -d $SRC || mkdir $SRC
    test -d $DST && continue

    echo "Cloning: $REPO into '$DST'"

    git clone $(__make_git_url $SRC $REPO) $DST &> /dev/null
  done

}

__push_repo_to_destiny(){
  # Copy all the repos to the destiny source control
  # ================================================
  for REPO in $(ls $SRC)
  do
    cd $SRC/$REPO

    echo -e "- $REPO"

    # Git repo realm

    git remote set-url origin $(__make_git_url $DST $REPO)
    git remote -v
    git push origin master -f

    # Git repo realm

    cd - &> /dev/null
  done
}

echo -e ":: Cloning Repos ::\n"
__clone_repos

echo

echo -e ":: Pushing repos to \`$DST\` ::\n"
__push_repo_to_destiny
