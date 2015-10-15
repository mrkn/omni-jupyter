set -xe

apt-get update -y

apt-get install -y --force-yes \
  julia \
  unixodbc \
  unixodbc-dev \
  odbc-postgresql \
  libmyodbc

julia /tmp/julia_stack/install_packages.jl
