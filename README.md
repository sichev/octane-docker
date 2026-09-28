# Docker image for PHP services
This project makes Docker images for PHP and Laravel projects. There are two types of images:

- **OpenSwoole**: for Laravel Octane.
- **FPM**: for usual PHP-FPM projects.

Each image has all the usual PHP extensions and tools. The images use official base images and native binaries.

Each tag contains a multi-architecture image. You can use the same tag on these platforms:

- **amd64**: Windows desktops and Linux servers.
- **arm64v8**: Apple M-series computers and some Linux servers.

# How to build the images

## Requirements
- Docker Desktop (with `buildx`).
- A Docker Hub account. Log in before you start the build (`docker login`).

## Configuration
The build scripts read the Docker Hub namespace and the image names from the `.env` file. This file is in the
project root. Git does not keep this file.

To make the `.env` file:

1. Copy the example file:
   ```shell
   cp .env.example .env
   ```
2. Change the values to your values.

| Variable           | Script       | Description                                                             | Default value       |
|--------------------|--------------|-------------------------------------------------------------------------|---------------------|
| `DOCKER_REPO`      | all scripts  | Docker Hub namespace (user or organization)                             | `sichev`            |
| `FPM_IMAGE`        | `build.sh`   | Name of the FPM image. The dev image name has the `-dev` suffix.        | `fpm`               |
| `OPENSWOOLE_IMAGE` | `build.sh`   | Name of the OpenSwoole image. The dev image name has the `-dev` suffix. | `octane-openswoole` |
| `SWOOLE_IMAGE`     | `sandbox.sh` | Name of the experimental Swoole image                                   | `php-swoole`        |

> **NOTE:** If a variable is missing, the script stops before the build starts.

> **NOTE:** The scripts contain the version tags and the `stable` and `latest` tags. Change them in the scripts.

## Build
To build all images and push them to Docker Hub, run this command:

```shell
bin/build.sh
```

You can start the script from any folder. The script always reads the `.env` file from the project root.

The **bin/sandbox.sh** script builds experimental images. It does not push them to Docker Hub. Some of these
builds can fail.

# TO-DO
- [x] Make tags for all PHP versions.
- [x] Move the Docker Hub namespace and the image names to environment variables.

# Examples
The examples use the published `sichev/*` images. If you use your images, change the names.

## Use the images for local development
Before you start, make sure that Docker Desktop (or an equivalent tool) is installed and running.

Add these aliases to your shell profile (for example, `~/.zshrc`). Other shells can need small changes.
You can also use the FPM image in the aliases.

```shell
alias dr="docker run --rm -v .:/var/www -w /var/www -ti"
alias drl="dr -p 127.0.0.1:80:8000/tcp"
alias dro="dr sichev/octane-openswoole"
alias drol="drl sichev/octane-openswoole"
alias drod="dr sichev/octane-openswoole-dev"
alias drold="drl sichev/octane-openswoole-dev"
alias drc="dro composer"
alias drp="dro php"
alias drpl="drol php"
alias dra="drp artisan"
alias drpd="drod php -d xdebug.mode=debug -d xdebug.start_with_request=yes -d xdebug.client_host=host.docker.internal -d xdebug.client_port=9000"
alias drpld="drold php -d xdebug.mode=debug -d xdebug.start_with_request=yes -d xdebug.client_host=host.docker.internal -d xdebug.client_port=9000"
alias drad="drpd artisan"
```

| Alias           | Function                                                               |
|-----------------|------------------------------------------------------------------------|
| `dro`           | Runs a command in the container.                                       |
| `drc`           | Runs Composer.                                                         |
| `dra`           | Runs an Artisan command. Start it from the project root.               |
| `d` at the end  | Uses the dev image with Xdebug. Use it to debug.                       |
| `l` in the name | Connects the port (for example, `drol` or `drold`). Use it for Octane. |

> **CAUTION:** The container does not keep changes to its files. When the command stops, all changes are lost.
> To keep the files, mount the folder from the host.

## Use the images with Laravel Octane
Before you start, install and configure Laravel Octane in your project.

1. Make a `docker-compose.yml` file. Use this example:
   ```yaml
   services:
     web:
       image: sichev/octane-openswoole
       extra_hosts:
         - 'host.docker.internal:host-gateway'
       ports:
         - "127.0.0.1:${APP_PORT}:${APP_PORT}"
       volumes:
         - .:/var/www
         # Optional: replace the default configuration in the container with your file:
         - ./.config/php/php.ini:/usr/local/etc/php/php.ini
       entrypoint:
         - '/usr/local/bin/php'
         - '/var/www/artisan'
         - 'octane:start'
         - '--server=swoole'
         - '--host=0.0.0.0'
         - '--port=${APP_PORT}'
       restart: always
   ```
2. Set the `APP_PORT` variable in the `.env` file of your project. This variable is mandatory.
3. Start the container:
   ```shell
   docker compose up
   ```
   To run the container in the background, add the `-d` option.

You can also use the aliases with this project. For example, to run the Laravel migrations, use `dra migrate`.

> **CAUTION:** The container does not keep changes to its files. To keep the files, mount them from the host.

## Use a custom entrypoint
Use the Laravel Octane example. Change the `entrypoint` section to your command.
