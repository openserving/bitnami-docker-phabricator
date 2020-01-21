# What is Phabricator?

> Phabricator is a collection of open source web applications that help software companies build better software. Phabricator is built by developers for developers. Every feature is optimized around developer efficiency for however you like to work. Code Quality starts with effective collaboration between team members.

https://www.phacility.com/phabricator/

# TL;DR

## Docker Compose

```bash
$ curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-phabricator/master/docker-compose.yml > docker-compose.yml
$ docker-compose up -d
```

# Why use Bitnami Images?

* Bitnami closely tracks upstream source changes and promptly publishes new versions of this image using our automated systems.
* With Bitnami images the latest bug fixes and features are available as soon as possible.
* Bitnami containers, virtual machines and cloud images use the same components and configuration approach - making it easy to switch between formats based on your project needs.
* All our images are based on [minideb](https://github.com/bitnami/minideb) a minimalist Debian based container image which gives you a small base container image and the familiarity of a leading linux distribution.
* All Bitnami images available in Docker Hub are signed with [Docker Content Trust (DTC)](https://docs.docker.com/engine/security/trust/content_trust/). You can use `DOCKER_CONTENT_TRUST=1` to verify the integrity of the images.
* Bitnami container images are released daily with the latest distribution packages available.


> This [CVE scan report](https://quay.io/repository/bitnami/phabricator?tab=tags) contains a security report with all open CVEs. To get the list of actionable security issues, find the "latest" tag, click the vulnerability report link under the corresponding "Security scan" field and then select the "Only show fixable" filter on the next page.

# How to deploy Phabricator in Kubernetes?

Deploying Bitnami applications as Helm Charts is the easiest way to get started with our applications on Kubernetes. Read more about the installation in the [Bitnami Phabricator Chart GitHub repository](https://github.com/bitnami/charts/tree/master/upstreamed/phabricator).

Bitnami containers can be used with [Kubeapps](https://kubeapps.com/) for deployment and management of Helm Charts in clusters.

# Supported tags and respective `Dockerfile` links

> NOTE: Debian 8 images have been deprecated in favor of Debian 9 images. Bitnami will not longer publish new Docker images based on Debian 8.

Learn more about the Bitnami tagging policy and the difference between rolling tags and immutable tags [in our documentation page](https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/).


* [`2019-ol-7`, `2019.50.0-ol-7-r41` (2019/ol-7/Dockerfile)](https://github.com/bitnami/bitnami-docker-phabricator/blob/2019.50.0-ol-7-r41/2019/ol-7/Dockerfile)
* [`2019-debian-9`, `2019.50.0-debian-9-r30`, `2019`, `2019.50.0`, `2019.50.0-r30`, `latest` (2019/debian-9/Dockerfile)](https://github.com/bitnami/bitnami-docker-phabricator/blob/2019.50.0-debian-9-r30/2019/debian-9/Dockerfile)

Subscribe to project updates by watching the [bitnami/phabricator GitHub repo](https://github.com/bitnami/bitnami-docker-phabricator).

# Prerequisites

To run this application you need [Docker Engine](https://www.docker.com/products/docker-engine) >= `1.10.0`. [Docker Compose](https://www.docker.com/products/docker-compose) is recommended with a version `1.6.0` or later.

# How to use this image

Phabricator requires access to a MySQL database or MariaDB database to store information. We'll use our very own [MariaDB image](https://www.github.com/bitnami/bitnami-docker-mariadb) for the database requirements.

## Using Docker Compose

The main folder of this repository contains a functional [`docker-compose.yml`](https://github.com/bitnami/bitnami-docker-phabricator/blob/master/docker-compose.yml) file. Run the application using it as shown below:

```bash
$ curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-phabricator/master/docker-compose.yml > docker-compose.yml
$ docker-compose up -d
```

## Using the Docker Command Line

If you want to run the application manually instead of using `docker-compose`, these are the basic steps you need to run:

1. Create a network

  ```bash
  $ docker network create phabricator-tier
  ```

2. Create a volume for MariaDB persistence and create a MariaDB container

  ```bash
  $ docker volume create --name mariadb_data
  $ docker run -d --name mariadb -e ALLOW_EMPTY_PASSWORD=yes -e MARIADB_EXTRA_FLAGS=--local-infile=0 \
    --net phabricator-tier \
    --volume mariadb_data:/bitnami \
    bitnami/mariadb:latest
  ```

3. Create volumes for Phabricator persistence and launch the container

  ```bash
  $ docker volume create --name phabricator_data
  $ docker run -d --name phabricator -p 80:80 -p 443:443 \
    --net phabricator-tier \
    --volume phabricator_data:/bitnami \
    bitnami/phabricator:latest
  ```

Access your application at <http://your-ip/>

## Persisting your application

If you remove the container all your data and configurations will be lost, and the next time you run the image the database will be reinitialized. To avoid this loss of data, you should mount a volume that will persist even after the container is removed.

For persistence you should mount a volume at the `/bitnami` path. Additionally you should mount a volume for [persistence of the MariaDB data](https://github.com/bitnami/bitnami-docker-mariadb#persisting-your-database).

The above examples define docker volumes namely `mariadb_data` and `phabricator_data`. The Phabricator application state will persist as long as these volumes are not removed.

To avoid inadvertent removal of these volumes you can [mount host directories as data volumes](https://docs.docker.com/engine/tutorials/dockervolumes/). Alternatively you can make use of volume plugins to host the volume data.

### Mount host directories as data volumes with Docker Compose

This requires a minor change to the [`docker-compose.yml`](https://github.com/bitnami/bitnami-docker-phabricator/blob/master/docker-compose.yml) file present in this repository:

```yaml
services:
  mariadb:
  ...
    volumes:
      - /path/to/mariadb-persistence:/bitnami
  ...
  phabricator:
  ...
    volumes:
      - /path/to/phabricator-persistence:/bitnami
  ...
```

### Mount host directories as data volumes using the Docker command line

1. Create a network (if it does not exist)

  ```bash
  $ docker network create phabricator-tier
  ```

2. Create a MariaDB container with host volume

  ```bash
  $ docker run -d --name mariadb -e ALLOW_EMPTY_PASSWORD=yes -e MARIADB_EXTRA_FLAGS=--local-infile=0 \
    --net phabricator-tier \
    --volume /path/to/mariadb-persistence:/bitnami \
    bitnami/mariadb:latest
  ```

3. Create the Phabricator the container with host volumes

  ```bash
  $ docker run -d --name phabricator -p 80:80 -p 443:443 \
    --net phabricator-tier \
    --volume /path/to/phabricator-persistence:/bitnami \
    bitnami/phabricator:latest
  ```

# Upgrading Phabricator

Bitnami provides up-to-date versions of MariaDB and Phabricator, including security patches, soon after they are made upstream. We recommend that you follow these steps to upgrade your container. We will cover here the upgrade of the Phabricator container. For the MariaDB upgrade see https://github.com/bitnami/bitnami-docker-mariadb/blob/master/README.md#upgrade-this-image

The `bitnami/phabricator:latest` tag always points to the most recent release. To get the most recent release you can simple repull the `latest` tag from the Docker Hub with `docker pull bitnami/phabricator:latest`. However it is recommended to use [tagged versions](https://hub.docker.com/r/bitnami/phabricator/tags/).

1. Get the updated images:

  ```bash
  $ docker pull bitnami/phabricator:latest
  ```

2. Stop your container

 * For docker-compose: `$ docker-compose stop phabricator`
 * For manual execution: `$ docker stop phabricator`

3. Take a snapshot of the application state

```bash
$ rsync -a /path/to/phabricator-persistence /path/to/phabricator-persistence.bkp.$(date +%Y%m%d-%H.%M.%S)
```

Additionally, [snapshot the MariaDB data](https://github.com/bitnami/bitnami-docker-mariadb#step-2-stop-and-backup-the-currently-running-container)

You can use these snapshots to restore the application state should the upgrade fail.

4. Remove the currently running container

 * For docker-compose: `$ docker-compose rm -v phabricator`
 * For manual execution: `$ docker rm -v phabricator`

5. Run the new image

 * For docker-compose: `$ docker-compose up phabricator`
 * For manual execution ([mount](#mount-persistent-folders-manually) the directories if needed): `docker run --name phabricator bitnami/phabricator:latest`

# Configuration

## Environment variables

The Phabricator instance can be customized by specifying environment variables on the first run. The following environment values are provided to customize Phabricator:

- `PHABRICATOR_HOST`: Phabricator host name. Default: **127.0.0.1**
- `PHABRICATOR_USERNAME`: Phabricator application username. Default: **user**
- `PHABRICATOR_PASSWORD`: Phabricator application password. Default: **bitnami1**
- `PHABRICATOR_EMAIL`: Phabricator application email. Default: **user@example.com**
- `PHABRICATOR_FIRSTNAME`: Phabricator user first name. Default: **FirstName**
- `PHABRICATOR_LASTNAME`: Phabricator user last name. Default: **LastName**
- `PHABRICATOR_ALTERNATE_FILE_DOMAIN`: Phabricator File Domain.
- `PHABRICATOR_USE_LFS`: Configure Phabricator to use Git LFS. Default: **no**
- `PHABRICATOR_SSH_PORT_NUMBER`: SSH Server Port. Default: **22**
- `PHABRICATOR_ENABLE_GIT_SSH_REPOSITORY`: Configure a self-hosted GIT repository with SSH authentication. Default: **no**
- `MARIADB_USER`: Root user for the MariaDB database. Default: **root**
- `MARIADB_PASSWORD`: Root password for the MariaDB.
- `MARIADB_HOST`: Hostname for MariaDB server. Default: **mariadb**
- `MARIADB_PORT_NUMBER`: Port used by MariaDB server. Default: **3306**

### Specifying Environment variables using Docker Compose

This requires a change to the [`docker-compose.yml`](https://github.com/bitnami/bitnami-docker-phabricator/blob/master/docker-compose.yml) file present in this repository:

```yaml
services:
  mariadb:
  ...
    environment:
      - ALLOW_EMPTY_PASSWORD=yes
      - MARIADB_EXTRA_FLAGS=--local-infile=0
  ...
  phabricator:
  ...
    environment:
      - PHABRICATOR_PASSWORD=my_password
  ...
```

### Specifying Environment variables on the Docker command line

```bash
$ docker run -d --name phabricator -p 80:80 -p 443:443 \
  --net phabricator-tier \
  --env PHABRICATOR_PASSWORD=my_password \
  --volume phabricator_data:/bitnami \
  bitnami/phabricator:latest
```

### SMTP Configuration

To configure phabricator to send email using SMTP you can set the following environment variables:

 - `SMTP_HOST`: SMTP host. No defaults
 - `SMTP_PORT`: SMTP port. No defaults
 - `SMTP_USER`: SMTP account user. No defaults
 - `SMTP_PASSWORD`: SMTP account password. No defaults
 - `SMTP_PROTOCOL`: SMTP protocol. No defaults. Possible values are `ssl` for port 465 and `tls` for port 587

This would be an example of SMTP configuration using a GMail account:

 * By modifying the [`docker-compose.yml`](https://github.com/bitnami/bitnami-docker-phabricator/blob/master/docker-compose.yml) file present in this repository:


```yaml
  phabricator:
  ...
    environment:
      - SMTP_HOST=smtp.gmail.com
      - SMTP_PORT=587
      - SMTP_USER=your_email@gmail.com
      - SMTP_PASSWORD=your_password
      - SMTP_PROTOCOL=tls
  ...
```

 * For manual execution:

```bash
 $ docker run -d -e SMTP_HOST=smtp.gmail.com -e SMTP_PORT=587 -e SMTP_USER=your_email@gmail.com -e SMTP_PASSWORD=your_password -e SMTP_PROTOCOL=tls -p 80:80 --name phabricator -v /your/local/path/bitnami/phabricator:/bitnami --net=phabricator_network bitnami/phabricator
```

# How to migrate from a Bitnami Phabricator Stack

You can follow these steps in order to migrate it to this container:

1. Export the data from your SOURCE installation: (assuming an installation in `/bitnami` directory)

  ```bash
  $ cd /bitnami/phabricator/apps/phabricator/htdocs/bin
  $ ./storage dump | gzip > ~/backup-phabricator-mysql-dumps.sql.gz
  $ cd /bitnami/phabricator/apps/phabricator/data/
  $ tar -zcvf ~/backup-phabricator-localstorage.tar.gz .
  $ cd /bitnami/phabricator/apps/phabricator/repo/
  $ tar -zcvf ~/backup-phabricator-repos.tar.gz .
  ```

2. Copy the backup files to your TARGET installation:

  ```bash
  $ scp ~/backup-phabricator-* YOUR_USERNAME@TARGET_HOST:~
  ```

3. Create the Phabricator Container as described in the section #How to use this Image (Using Docker Compose)

4. Wait for the initial setup to finish. You can follow it with

  ```bash
  $ docker-compose logs -f phabricator
  ```

  and press `Ctrl-C` when you see this:

  ```
  nami    INFO  phabricator successfully initialized
  Starting application ...

    *** Welcome to the phabricator image ***
    *** Brought to you by Bitnami ***
  ```

5. Stop Phabricator daemon:

  ```bash
  $ docker-compose exec phabricator nami stop phabricator
  ```

6. Restore and upgrade the database: (replace ROOT_PASSWORD below with your MariaDB root password)

  ```bash
  $ cd ~
  $ docker-compose exec phabricator /opt/bitnami/phabricator/bin/storage destroy --force
  $ gunzip -c ./backup-phabricator-mysql-dumps.sql.gz | docker-compose exec mariadb mysql -pROOT_PASSWORD
  $ docker-compose exec phabricator /opt/bitnami/phabricator/bin/storage upgrade --force
  ```

7. Restore repositories from backup:

  ```bash
  $ cat ./backup-phabricator-repos.tar.gz | docker-compose exec phabricator bash -c 'cd /bitnami/phabricator/repo ; tar -xzvf -'
  ```

8. Restore local storage files:

  ```bash
  $ cat ./backup-phabricator-localstorage.tar.gz | docker-compose exec phabricator bash -c 'cd /bitnami/phabricator/data ; tar -xzvf -'
  ```

9. Fix repositories storage location: (replace ROOT_PASSWORD below with your MariaDB root password)

  ```bash
  $ cat | docker-compose exec mariadb mysql -pROOT_PASSWORD <<EOF
USE bitnami_phabricator_repository;
UPDATE repository SET localPath = REPLACE(localPath, '/bitnami/apps/phabricator/repo/', '/opt/bitnami/phabricator/repo/');
COMMIT;
EOF
  ```

10. Fix Phabricator directory permissions:

  ```bash
  $ docker-compose exec phabricator chown -R phabricator:phabricator /bitnami/phabricator
  ```

11. Restart Phabricator container:

  ```bash
  $ docker-compose restart phabricator
  ```

# Customize this image

The Bitnami Phabricator Docker image is designed to be extended so it can be used as the base image for your custom web applications.

## Extend this image

Before extending this image, please note there are certain configuration settings you can modify using the original image:

- Settings that can be adapted using environment variables. For instance, you can change the ports used by Apache for HTTP and HTTPS, by setting the environment variables `APACHE_HTTP_PORT_NUMBER` and `APACHE_HTTPS_PORT_NUMBER` respectively.
- [Adding custom virtual hosts](https://github.com/bitnami/bitnami-docker-apache#adding-custom-virtual-hosts).
- [Replacing the 'httpd.conf' file](https://github.com/bitnami/bitnami-docker-apache#full-configuration).
- [Using custom SSL certificates](https://github.com/bitnami/bitnami-docker-apache#using-custom-ssl-certificates).

If your desired customizations cannot be covered using the methods mentioned above, extend the image. To do so, create your own image using a Dockerfile with the format below:

```Dockerfile
FROM bitnami/phabricator
## Put your customizations below
...
```

Here is an example of extending the image with the following modifications:

- Install the `vim` editor
- Modify the Apache configuration file
- Modify the ports used by Apache

```Dockerfile
FROM bitnami/phabricator
LABEL maintainer "Bitnami <containers@bitnami.com>"

## Install 'vim'
RUN install_packages vim

## Enable mod_ratelimit module
RUN sed -i -r 's/#LoadModule ratelimit_module/LoadModule ratelimit_module/' /opt/bitnami/apache/conf/httpd.conf

## Modify the ports used by Apache by default
# It is also possible to change these environment variables at runtime
ENV APACHE_HTTP_PORT_NUMBER=8181
ENV APACHE_HTTPS_PORT_NUMBER=8143
EXPOSE 8181 8143
```

Based on the extended image, you can use a Docker Compose file like the one below to add other features:

```yaml
version: '2'
services:
  mariadb:
    image: 'bitnami/mariadb:10.3'
    environment:
      - ALLOW_EMPTY_PASSWORD=yes
      - MARIADB_EXTRA_FLAGS=--local-infile=0
    volumes:
      - 'mariadb_data:/bitnami'
  phabricator:
    build: .
    ports:
      - '80:8181'
      - '443:8143'
    volumes:
      - 'phabricator_data:/bitnami'
    depends_on:
      - mariadb
volumes:
  mariadb_data:
    driver: local
  phabricator_data:
    driver: local
```

# Notable Changes

## 2019.21.0-debian-9-r3 and 2019.21.0-ol-7-r3

- This image has been adapted so it's easier to customize. See the [Customize this image](#customize-this-image) section for more information.
- The Apache configuration volume (`/bitnami/apache`) has been deprecated, and support for this feature will be dropped in the near future. Until then, the container will enable the Apache configuration from that volume if it exists. By default, and if the configuration volume does not exist, the configuration files will be regenerated each time the container is created. Users wanting to apply custom Apache configuration files are advised to mount a volume for the configuration at `/opt/bitnami/apache/conf`, or mount specific configuration files individually.
- The PHP configuration volume (`/bitnami/php`) has been deprecated, and support for this feature will be dropped in the near future. Until then, the container will enable the PHP configuration from that volume if it exists. By default, and if the configuration volume does not exist, the configuration files will be regenerated each time the container is created. Users wanting to apply custom PHP configuration files are advised to mount a volume for the configuration at `/opt/bitnami/php/conf`, or mount specific configuration files individually.
- Enabling custom Apache certificates by placing them at `/opt/bitnami/apache/certs` has been deprecated, and support for this functionality will be dropped in the near future. Users wanting to enable custom certificates are advised to mount their certificate files on top of the preconfigured ones at `/certs`.

# Contributing

We'd love for you to contribute to this container. You can request new features by creating an [issue](https://github.com/bitnami/bitnami-docker-phabricator/issues), or submit a [pull request](https://github.com/bitnami/bitnami-docker-phabricator/pulls) with your contribution.

# FAQ

You can search for frequently asked questions (and answers) in the GitHub issue list. These are marked with the label [faq](https://github.com/bitnami/bitnami-docker-phabricator/issues?utf8=%E2%9C%93&q=label%3Afaq%20).

# Issues

If you encountered a problem running this container, you can file an [issue](https://github.com/bitnami/bitnami-docker-phabricator/issues). For us to provide better support, be sure to include the following information in your issue:

- Host OS and version
- Docker version (`docker version`)
- Output of `docker info`
- Version of this container (`echo $BITNAMI_IMAGE_VERSION` inside the container)
- The command you used to run the container, and any relevant output you saw (masking any sensitive information)

# License

Copyright 2016-2020 Bitnami

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
