# Docker image for PHP services
The main purpose of this project is to create self-enough docker images for average PHP/Laravel projects backed with 
*open-swoole* extension (Octane way) or just a regular FPM, but with all bells and whistles included. Maximum usage of 
native images and binaries. And a multi-arch image under one tag. So it will be possible to use *amd64* arch (Windows 
desktop and Linux servers) as well as *arm64v8* (Apple M series and some modern Linux servers).

# How to use builder
We have a script – **bin/build.sh**. Run it from the root folder, and it will build everything you need. **Docker for 
Desktop** is required. Some tuning is also required. And after the success build, image will be pushed to the Hub. 
If you fork this, please change tags to yours.

# TO-DO
List of unfinished tasks:

- [x] Made custom tags that represent all used or specified versions. 
- [ ] Extract Docker Hub name and everything, what is possible to ENV variables (restored) 

# Examples
## Example how to use already built images for the local development

Expecting that Docker for desktop (or any other variation) is installed locally, configured and running.
To simplify usage, add these aliases to your shell profile/RC script (may need to adopt a bit for a specific shell).
Currently, it uses the current image from this repository. Change to own if needed. FPM image also may be used.

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
alias drpld="drold php -d xdebug.mode=debug -d xdebug.start_with_request=yes -d xdebug.client_host=host.docker.internal -d xdebug.client_port=9000"
alias drad="drpd artisan"
```

- `dro` is used to run any command in the container
- `drc` for a composer
- `dra` for any artisan command (assume that you are in the project root folder)
- all aliases with **d** in the end execute a debug mode in the dev image (with enabled xDebug)
- if needed to map a port (for octane image), use commands with **l** (small L) keyword (like `drol` or `drold`) 
- beware that images are read-only and all changes will be lost after the end of command execution. If you need to keep
  them, you need to mount that folder/files to the host.

## Example how to use images for the projects with Laravel Octane

Expecting that you already installed and configured all that Octane stuff.

use a docker-compose.yml file like this:
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
      # or add your own configs to replace the default ones inside the container:
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

then just simply run `docker-compose up` (or with a `-d` key for daemon) and you are ready to go.

Or when all images are already built, you can run `dra migrate` to run Laravel migrations, for example. 
Please note that all files changes in the container will be lost after the command execution. If you need to keep 
them, you need to mount them to the host.

**APP_PORT** value is **mandatory** to work. Put it in your .env file.

## Running a custom entrypoint

Actually, it's pretty same as the previous example, but you need to tune the entrypoint section.

