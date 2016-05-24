import Html exposing (Html, button, div, text)
import Html.App as Html
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram { model = initialCount, view = view, update = update }

-- MODEL
type alias Model = Int

initialCount : Model
initialCount =
  0

-- UPDATE
type Msg = Increment | Decrement | Reset

update : Msg -> Model -> Model
update msg count =
  case msg of
    Increment ->
      count + 1

    Decrement ->
      count - 1

    Reset ->
      initialCount

-- VIEW
view : Model -> Html Msg
view count =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString count) ]
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick Reset     ] [ text "Reset" ]
    ]
