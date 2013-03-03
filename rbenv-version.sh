#!/bin/bash

# Prints the current rbenv version used
#
# Based on 
#   http://stackoverflow.com/questions/14635206/rbenv-version-display-in-zsh-right-prompt-not-refreshing

RBENV_RUBY_VERSION=''
if which rvm-prompt &> /dev/null; then
  RBENV_RUBY_VERSION="$(rvm-prompt i v g)"
else
  if which rbenv &> /dev/null; then
    RBENV_RUBY_VERSION="$(rbenv version | sed -e "s/ (set.*$//")"
  fi
fi
echo $RBENV_RUBY_VERSION