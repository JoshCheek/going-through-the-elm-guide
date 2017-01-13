-- Going to first try this one on my own, then read their description once I get stuck.
{- We are going to make a simple clock.

   So far we have focused on commands. With the randomness example,
   we asked for a random value. With the HTTP example, we asked for info from a server.
   That pattern does not really work for a clock. In this case,
   we want to sit around and hear about clock ticks whenever they happen.
   This is where subscriptions come in.

   The code is not too crazy here, so I am going to include it in full.
   After you read through, we will come back to normal words that explain it in more depth.
-}


module Main exposing (..)

import Html exposing (Html)
import Svg exposing (Svg, circle, svg, text, polygon, rect, line)
import Svg.Attributes exposing (viewBox, fill, points, transform, x, y, version, r, cx, cy, stroke, strokeWidth, x1, x2, y1, y2)
import Time exposing (every, second)


main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type Clock
    = Unset
    | Seconds Int


type Msg
    = UpdateSeconds Int


init : ( Clock, Cmd Msg )
init =
    ( Unset, Cmd.none )


update : Msg -> Clock -> ( Clock, Cmd Msg )
update msg model =
    case msg of
        UpdateSeconds seconds ->
            ( Seconds seconds, Cmd.none )


subscriptions : Clock -> Sub Msg
subscriptions clock =
    Time.every second (\s -> UpdateSeconds (Basics.floor (s / 1000)))


view : Clock -> Svg Msg
view clock =
    case clock of
        Unset ->
            clockDisplay 0 0 0

        Seconds seconds ->
            let
                secondHand =
                    seconds % 60

                minuteHand =
                    (seconds // 60) % 60

                hourHand =
                    (seconds // 60 // 60) % 12
            in
                clockDisplay hourHand minuteHand secondHand


(@=) fn attr =
    fn (toString attr)
infixr 1 @=



-- clockDisplay : Float -> Float -> Float -> Svg.Svg


clockDisplay hours minutes seconds =
    let
        faceWidth =
            100

        faceHeight =
            100

        noseX =
            30

        noseY =
            30

        radius =
            20

        face =
            circle
                [ fill "#A84"
                , cx @= noseX
                , cy @= noseY
                , r @= radius
                ]
                []

        nose =
            circle
                [ fill "black"
                , cx @= noseX
                , cy @= noseY
                , r @= radius / 12
                ]
                []

        hand ticksTaken ticksAvailable r width =
            let
                percentComplete =
                    (toFloat ticksTaken) / (toFloat ticksAvailable)

                quarterTurn =
                    Basics.pi / 2

                fullTurn =
                    Basics.pi * 2

                angle =
                    fullTurn * percentComplete - quarterTurn

                distalX =
                    (cos angle) * r + noseX

                distalY =
                    (sin angle) * r + noseY
            in
                line
                    [ x1 @= noseX
                    , y1 @= noseY
                    , x2 @= distalX
                    , y2 @= distalY
                    , stroke "black"
                    , strokeWidth <| toString width
                    ]
                    []
    in
        svg
            [ version "1.1"
            , x "0"
            , y "0"
            , viewBox <| "0 0 " ++ toString faceWidth ++ " " ++ toString faceHeight
            ]
            [ face
            , nose
            , hand hours 12 (radius / 2.0) 1.5
            , hand minutes 60 (radius / 1.5) 1.0
            , hand seconds 60 (radius / 1.1) 0.5
            ]
