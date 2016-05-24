import Html exposing (Html, div, input, p, text)
import Html.App
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import String exposing (reverse)

main =
  Html.App.beginnerProgram { model = initialText, update = update, view = view  }

type alias Model = String
type Msg = ChangeText String

initialText : Model
initialText =
  ""

update : Msg -> Model -> Model
update msg crntText =
  case msg of
    ChangeText newText ->
      newText

view : Model -> Html Msg
view crntText =
  div []
      [ input [ placeholder "Text to reverse", onInput ChangeText ] []
      , p [] [text (reverse crntText)]
      ]
