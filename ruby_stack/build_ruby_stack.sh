#!/usr/bin/env bash

set -xe

RUBY_VERSION=2.2.3

apt-get update -y
apt-get build-dep -y ruby2.0
apt-get install -y \
  git-core \
  libffi-dev \
  libgmp-dev \
  libzmq3-dev \
  libatlas-base-dev \
  libmysqlclient-dev \
  libpq-dev \
  libgsl0-dev

mkdir -p /opt
git clone https://github.com/sstephenson/rbenv.git /opt/rbenv
git clone https://github.com/sstephenson/ruby-build.git /opt/rbenv/plugins/ruby-build

export RBENV_ROOT=/opt/rbenv
export PATH=/opt/rbenv/bin:$PATH
eval "$(rbenv init -)"

rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION

gem update --system
gem install bundler
gem install mysql2
gem install pg
gem install rails
gem install activerecord4-redshift-adapter
gem install iruby
gem install nyaplot
gem install statsample
gem install statsample-optimization
gem install mikon
gem install nmatrix-lapacke nmatrix-atlas

rbenv rehash

iruby register

# Reduce the image size
apt-get autoremove -y
apt-get clean -y
