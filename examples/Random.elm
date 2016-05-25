import Html exposing (Html, div, h1, button, text)
import Html.App as Html
import Html.Events exposing (onClick)
import Random

main =
  Html.program
    { init          = init
    , update        = update
    , view          = view
    , subscriptions = subscriptions
    }

type alias Model =
  { dieFace : Int
  }

type Msg = Roll
         | NewFace Int

init : (Model, Cmd Msg)
init =
  (Model 1, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))
    NewFace newFace ->
      ({ model | dieFace = newFace }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  div
    []
    [ h1 [] [text (toString model.dieFace)]
    , button [onClick Roll] []
    ]
