import Html exposing (ul, li, input, button, text, div)
import Html.Attributes exposing (value, placeholder)

main =
  Html.program
  { init = init
  , update = update
  , view = view
  , subscriptions = subscriptions
  }

type alias Model =
  { message : String
  , messages : List String
  }

type Msg
  = NoMsg

init =
  (Model "" [], Cmd.none)

update msg model =
  case msg of
    NoMsg -> (model, Cmd.none)

subscriptions model =
  Sub.none

view model =
  let
      viewMessage message =
        li [] [text message]
  in
    div []
      [ input [placeholder "Message", value model.message] []
      , button [] [text "send"]
      , ul [] (List.map viewMessage model.messages)
      ]
