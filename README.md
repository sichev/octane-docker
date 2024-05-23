# Docker image for Laravel Octane
Main purpose of this project is to create a self-enough docker image for an average Laravel Octane project backed with 
*open-swoole* extention. Maximum usage of native images, but need to build a multi-arch images under one tag. 
So it will be possible to use *amd64* arch as well as *arm64v8*. 

(NOT YET) Plus a 2 variants of each - *dev* with xdebug and *prod* without. 

# How to use
We have a script - **build.sh**. Run it and it will build everything you need. 
After that the only will be needed to publish this. So it will be possible to re-use image with other projects. 

# TO-DO
List of unfinished tasks:

- Test current image with current project & adopt it to run everything.
- Made separate Dev and Prod images. With a small tuning between them.
- Implement an instruction/script how to activate an application (optional):
    - install laravel skeleton app or from git current project
    - install composer and node packages
    - install a new key if app is new
    - made all migrations 
    - everything of it easy to run. Made a script or just an instruction.

