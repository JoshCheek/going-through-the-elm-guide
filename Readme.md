Elm 0.17.0 Guide
================

Going through the [Elm Guide](http://guide.elm-lang.org/core_language.html)

Setup
-----

* [install](http://elm-lang.org/install)
* [vim plugin](https://github.com/lambdatoast/elm.vim)

Command Line Tools
------------------

* `elm` runs the others
* `elm package` rubygems for Elm (it can also diff versions of a dependency)
* `elm make` Rake for Elm
* `elm repl` irb for Elm (try entering `:help`)
* `elm reactor` development interpreter (not compiled),
   runs on `http://0.0.0.0:8000`  can hot-swap code, offers time-travel debugging (ie hot-swap the code and then replay the events)

They all take a `--help` flag.

Starting a new project
----------------------

Get an `elm-package.json` that installs the core elm stuff you'll need:

```sh
$ elm package install
Some new packages are needed. Here is the upgrade plan.

  Install:
    elm-lang/core 4.0.1

Do you approve of this plan? (y/n) y
Downloading elm-lang/core
Packages configured successfully!

$ ls -l
total 16
-rw-r--r--  1    810B May 24 12:01 Readme.md
-rw-r--r--  1    373B May 24 12:01 elm-package.json
drwxr-xr-x  4    136B May 24 12:02 elm-stuff/

$ cat elm-package.json
{
    "version": "1.0.0",
    "summary": "helpful summary of your project, less than 80 characters",
    "repository": "https://github.com/user/project.git",
    "license": "BSD3",
    "source-directories": [
        "."
    ],
    "exposed-modules": [],
    "dependencies": {
        "elm-lang/core": "4.0.1 <= v < 5.0.0"
    },
    "elm-version": "0.17.0 <= v < 0.18.0"
}
```









Not sure yet:

```sh
$ elm make Main.elm --output=index.html
```
