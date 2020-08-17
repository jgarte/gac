# Installation

## Dependencies

Use [chjize](https://github.com/pflanze/chjize) on a Debian compatible
system. Follow the instructions up to "Once you trust that the source
is mine", then as root:

    make gambit

And to use Emacs as root:

    make emacs

and as a (probably preferably fresh) non-root user (this modifies dot
files of that user, although it keeps originals in a git repo in the
home) from its home dir:

    /opt/chj/chjize/bin/mod-user

For this to take proper effect you need to make a fresh login as that
user. It will ask to run ~/.chj-home/init which you should do (it will
symlink ~/.emacs to the chj-emacs repo and set up other things).


## Checkout

After cloning this repo as the non-root user:

    cd gac
    git submodule init
    git submodule update

## Run

As the non-root user:

    cd gac
    emacs
    M-x run-scheme
    > (run-tests)      ;; run all tests
    > (run-tests ".")  ;; run just the tests for the files in this dir
    > (lily %tetrachords) ;; to generate a score

