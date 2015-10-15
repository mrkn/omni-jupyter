FROM jupyter/notebook
MAINTAINER Kenta Murata <mrkn@mrkn.jp>

# BLAS and LAPACK
# TODO: Need to backport libopenblas-base and lapack-pic packages for wily
#       because libopenblas-base for trusty does not include liblapack.so.3.

RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
      libopenblas-dev \
      libatlas-base-dev \
    && update-alternatives --set liblapack.so.3 /usr/lib/atlas-base/atlas/liblapack.so.3

# libfftw3

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
      libfftw3-dev \
      libfftw3-bin

# Python stack

RUN mkdir /tmp/python_stack
ADD python_stack/build_python_stack.sh /tmp/python_stack/
ADD python_stack/numpy-site.cfg /tmp/python_stack/
RUN DEBIAN_FRONTEND=noninteractive bash /tmp/python_stack/build_python_stack.sh
RUN python2 -c "import matplotlib, scipy, pandas, sklearn, seaborn, yt, patsy, sympy, IPython, statsmodels, pandas_td"
RUN python3 -c "import matplotlib, scipy, pandas, sklearn, seaborn, yt, patsy, sympy, IPython, statsmodels, pandas_td"
RUN rm -rf /tmp/python_stack

# Julia stack

ADD julia_stack/julia.list /etc/apt/sources.list.d/
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys CF979FFA3D3D3ACC
RUN mkdir /tmp/julia_stack
ADD julia_stack/build_julia_stack.sh /tmp/julia_stack/
ADD julia_stack/install_packages.jl /tmp/julia_stack/
RUN DEBIAN_FRONTEND=noninteractive bash /tmp/julia_stack/build_julia_stack.sh
RUN rm -rf /tmp/julia_stack

# Ruby stack

RUN mkdir -p /tmp/ruby_stack
COPY ruby_stack/build_ruby_stack.sh /tmp/ruby_stack/
COPY ruby_stack/ruby.sh /etc/profile.d/ruby.sh
RUN DEBIAN_FRONTEND=noninteractive bash /tmp/ruby_stack/build_ruby_stack.sh
RUN rm -rf /tmp/ruby_stack

# R stack

RUN mkdir -p /tmp/r_stack
ADD r_stack/cran.list /etc/apt/sources.list.d/
ADD r_stack/install_packages.R /tmp/r_stack/
ADD r_stack/build_r_stack.sh /tmp/r_stack/
RUN bash /tmp/r_stack/build_r_stack.sh
RUN rm -rf /tmp/r_stack
