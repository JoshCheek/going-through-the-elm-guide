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


The Elm Architecture
--------------------

* **Model** — the state of your application
* **Update** — a way to update your state
* **View** — a way to view your state as HTML


Starting a new project
----------------------

### New Repo

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

### Install `elm-html`

```sh
$ elm package install elm-lang/html
```

### First app

In the file `Main.elm`

```elm
import Html exposing (Html, button, div, text)
import Html.App as Html
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model = Int

model : Model
model =
  0

-- UPDATE
type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]
```


### Compile

```sh
$ elm make Main.elm --output=index.html
```

### Try it out

```sh
$ open ./index.html
```






Unclear
-------

* Why is there `type` and `type alias` instead of:
  * just `type` or
  * `type union` and `type alias`
