module Main exposing (..)

import Html exposing (Html, div, h2, button, img, text, button, input)
import Html.Attributes exposing (src, value, placeholder)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode

type alias ImageGenerator =
  { topic : String
  , imageUrl : String
  }

type Msg
  = NoMsg
  | GetRandomImage
  | ReplaceGif String
  | SetTopic String

main =
  Html.program
  { init = init "dogs"
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

defaultImageUrl =
  "https://upload.wikimedia.org/wikipedia/commons/3/3f/No-red.svg"

init : String -> (ImageGenerator, Cmd Msg)
init topic =
  ( ImageGenerator topic defaultImageUrl, getRandomImage topic )

update : Msg -> ImageGenerator -> (ImageGenerator, Cmd Msg)
update msg imgGen =
  case msg of
    NoMsg             -> (imgGen, Cmd.none)
    GetRandomImage    -> (imgGen, getRandomImage imgGen.topic)
    ReplaceGif newUrl -> ({ imgGen | imageUrl = newUrl }, Cmd.none)
    SetTopic newTopic -> ({ imgGen | topic = newTopic }, Cmd.none)

getRandomImage : String -> Cmd Msg
getRandomImage topic =
  let
    url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    getGif = Http.get url decodeGifUrl
    decodeGifUrl = Json.Decode.at ["data", "image_url"] Json.Decode.string
    replaceGif result =
      case result of
        Err _ -> NoMsg
        Ok url -> ReplaceGif url
  in
    Http.send replaceGif getGif

subscriptions : ImageGenerator -> Sub Msg
subscriptions imgGen =
  Sub.none


view : ImageGenerator -> Html Msg
view imgGen =
  let
    controls =
      div []
      [ input [placeholder "Topic", onInput SetTopic, value imgGen.topic] []
      , button [ onClick GetRandomImage ] [ text "Get Random Image" ]
      ]
    image =
      img [src imgGen.imageUrl] []
  in
    div [] [ controls, image ]
