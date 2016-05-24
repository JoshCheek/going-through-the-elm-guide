import Html exposing (Html, text, p, input, div)
import Html.App as Html
import Html.Events exposing (onInput)
import Html.Attributes exposing (placeholder)
import String

main =
  Html.beginnerProgram { model = initialText, update = update, view = view }

type alias Model = String
initialText : Model
initialText =
  ""


type Msg = UpdateText String

update : Msg -> Model -> Model
update msg currentText =
  case msg of
    UpdateText newText ->
      newText


-- http://package.elm-lang.org/packages/elm-lang/html/1.0.0/Html
-- div   : List (Attribute msg) -> List (Html msg) -> Html msg
-- p     : List (Attribute msg) -> List (Html msg) -> Html msg
-- input : List (Attribute msg) -> List (Html msg) -> Html msg
--    placeholder : String -> Attribute msg
--      http://package.elm-lang.org/packages/elm-lang/html/1.0.0/Html-Attributes#placeholder
--    onInput : (String -> msg) -> Attribute msg
--      http://package.elm-lang.org/packages/elm-lang/html/1.0.0/Html-Events#onInput
--      this one is interesting b/c I never talk about its value,
--      so its state is persisted within the rendered component,
--      presumably it would be wiped out if I returned a different representation?
--      or maybe its smarter than that and would only update the virtual DOM difference
view : Model -> Html Msg
view model =
  div []
    [
      input [ placeholder "Text to reverse", onInput UpdateText ] [],
      p [] [text (String.reverse model)]
    ]
