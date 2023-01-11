FROM ubuntu:jammy


# File Author / Maintainer
LABEL app.nominatim.image.authors="Vinicius Rodrigues Wovst"

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /app

#update libs
RUN apt-get update
RUN apt-get upgrade

# libs to build nominatim
RUN apt -y install cmake \
  build-essential \
  libbz2-dev \
  zlib1g-dev \
  libexpat1-dev \
  liblua5.4-dev \
  libboost-dev libboost-system-dev libboost-filesystem-dev \
  postgresql-contrib postgresql-14-postgis-3 postgresql-server-dev-14 \
  php php-intl php-pgsql php-cgi \
  acl \
  wget


#python
RUN apt -y install  python3-dev \
  python3-pip \
  python3-tidylib \
  python3-psycopg2 \
  python3-setuptools \
  python3-dotenv \
  python3-psutil \
  python3-jinja2 \
  python3-datrie \
  python3-icu \
  python3-argparse-manpage 


#misc
RUN apt -y install sudo

#create nominatim user
RUN useradd -d /srv/nominatim -s /bin/bash -m nominatim
RUN cd /srv/nominatim/
RUN setfacl -R -m u:nominatim:rwx /srv/nominatim/

# Nominatim install.
ENV NOMINATIM_VERSION 4.2.0

RUN wget https://nominatim.org/release/Nominatim-$NOMINATIM_VERSION.tar.bz2

RUN tar xvf Nominatim-$NOMINATIM_VERSION.tar.bz2
RUN cd Nominatim-$NOMINATIM_VERSION && \
  mkdir build && \
  cd build && \
  cmake ..
RUN cd Nominatim-$NOMINATIM_VERSION/build && make 
RUN cd Nominatim-$NOMINATIM_VERSION/build && make install

# Remove development and unused packages.
RUN apt-get -y remove --purge \
  cpp-9 \
  gcc-9* \
  g++ \
  git \
  make \
  cmake* \
  llvm-10* \
  libc6-dev \
  linux-libc-dev \
  libclang-*-dev \
  build-essential \
  liblua*-dev \
  postgresql-server-dev-14 \
  && apt-get clean \
  # Clear temporary files and directories.
  && rm -rf \
  /tmp/* \
  /var/tmp/* \
  /root/.cache \
  /app/src/.git \
  /var/lib/apt/lists/* \
  # Remove nominatim source and build directories
  && rm /app/*.tar.bz2 \
  && rm -rf /app/build \
  && rm -rf /app/Nominatim-$NOMINATIM_VERSION


RUN mkdir /app/osmdata

# Apache configuration
COPY config/apache.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 8087

ENTRYPOINT ["/app/scripts/start.sh"]