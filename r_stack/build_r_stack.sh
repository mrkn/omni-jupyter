set -xe

update-alternatives --set liblapack.so.3 /usr/lib/atlas-base/atlas/liblapack.so.3
update-alternatives --set libblas.so.3 /usr/lib/atlas-base/atlas/libblas.so.3

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes \
  r-base-dev \
  r-recommended \
  libzmq3-dev

Rscript /tmp/r_stack/install_packages.R
