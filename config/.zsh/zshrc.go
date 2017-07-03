#!/bin/bash

if [ ! -d $HOME/src/github.com/motemen ]; then
  go get github.com/motemen/ghq
fi

export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH
