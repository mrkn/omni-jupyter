#!/usr/bin/env bash

# This script is based on https://github.com/ipython/docker-notebook/blob/master/scipystack/build_scipy_stack.sh

set -xe

apt-get -y update

apt-get build-dep -y \
  python3 \
  python3-numpy \
  python3-scipy \
  cython3 \
  python3-h5py

apt-get install -y \
  build-essential \
  gfortran \
  git-core \
  curl \
  python3-dev \
  libfreetype6-dev \
  libpng12-dev \
  libcairo2-dev

# PIP
curl https://bootstrap.pypa.io/get-pip.py | python2
curl https://bootstrap.pypa.io/get-pip.py | python3

# NumPy
cp /tmp/python_stack/numpy-site.cfg ~/.numpy-site.cfg

for PYTHONVER in 2 3 ; do
  PYTHON="python$PYTHONVER"
  PIP="pip$PYTHONVER"

  $PIP install -U numpy
  $PIP install -U scipy
  $PIP install -U cairocffi matplotlib
  $PIP install -U pandas
  $PIP install -U sympy
  $PIP install -U nose
  $PIP install -U scikit-learn
  $PIP install -U seaborn
  $PIP install -U h5py
  $PIP install -U yt
  $PIP install -U patsy
  $PIP install -U ggplot
  $PIP install -U statsmodels
  $PIP install -U pandas-td
done

# Reduce the image size
apt-get autoremove -y
apt-get clean -y
