module Main exposing (..)

import Html exposing (Html, div, input, p, text)
import Html.Attributes exposing (placeholder, style, autofocus)
import Html.Events exposing (onInput)
import String exposing (reverse)


main =
    Html.beginnerProgram { model = initialText, update = update, view = view }


type alias Model =
    String


type Msg
    = ChangeText String


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
    div
        [ style
            [ ( "padding", "2em" )
            , ( "font-size", "x-large" )
            , ( "background", "#853" )
            , ( "width", "100%" )
            , ( "height", "100%" )
            , ( "box-sizing", "border-box" )
            ]
        ]
        [ input
            [ placeholder "Text to reverse"
            , onInput ChangeText
            , autofocus True
            , style
                [ ( "font-size", "x-large" )
                , ( "display", "block" )
                , ( "width", "100%" )
                ]
            ]
            []
        , p [ style [ ( "color", "#4E8" ) ] ] [ text (reverse crntText) ]
        ]
