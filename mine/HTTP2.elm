module Main exposing (..)

import Html exposing (Html, div, h2, button, img, text)
import Html.Attributes exposing (src)

type alias ImageGenerator =
  { topic : String
  , imageUrl : String
  }

type Msg =
  NoMsg

main =
  Html.program
  { init = init "cats"
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

defaultImageUrl =
  "https://upload.wikimedia.org/wikipedia/commons/3/3f/No-red.svg"

init topic =
  ( ImageGenerator topic defaultImageUrl, Cmd.none )

update msg model =
  (model, Cmd.none)


subscriptions model =
  Sub.none


view : ImageGenerator -> Html Msg
view model =
  div []
    [ h2 [] [text model.topic]
    , img [src model.imageUrl] []
    ]

