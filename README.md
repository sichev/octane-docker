# Docker image for Laravel Octane
The main purpose of this project is to create self-enough docker images for an average Laravel Octane project backed with 
*open-swoole* extension. Maximum usage of native images, but need to build a multi-arch image under one tag. 
So it will be possible to use *amd64* arch as well as *arm64v8*. Maybe more in the future.

# How to use
We have a script - **build.sh**. Run it and it will build everything you need. 
And on the success build will push everything to the Hub. 

# TO-DO
List of unfinished tasks:

- [ ] Implement an instruction/script how to activate an application (optional):
    - [ ] install laravel skeleton app or from git current project
    - [ ] install composer and node packages
    - [ ] install a new key if the app is new
    - [ ] made all migrations 
    - [ ] everything of it is straightforward to run. Made a script or just an instruction.
- [x] Made custom tags that represent all used or specified versions. 
- [ ] Extract Docker Hub name to ENV 

# Example how to use images for the local development

Expecting that Docker for desktop (or any other variation) is installed locally and configured.
Insert this code to your shell profile script (may need to adopt a bit for a specific shell).

```shell
alias dr="docker run --rm -v .:/var/www -w /var/www -p 127.0.0.1:80:8000/tcp -ti"
alias dro="dr sichev/octane-openswoole"
alias drod="dr sichev/octane-openswoole-dev"
alias drc="dro composer"
alias drp="dro php"
alias dra="drp artisan"
alias drpd="drod php -d xdebug.mode=debug -d xdebug.start_with_request=yes -d xdebug.client_host=host.docker.internal -d xdebug.client_port=9000"
alias drad="drpd artisan"
```

- `dro` is used to run any command in the container
- `drc` for a composer
- `dra` for any artisan command (assume that you are in the project root folder)
- all aliases with **d** in the end execute a debug mode in the dev image (with enabled xDebug)
