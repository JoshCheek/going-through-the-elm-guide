module Main exposing (..)

import Html exposing (Html, ul, li, input, button, text, div)
import Html.Attributes exposing (value, placeholder)
import Html.Events exposing (onClick, onInput)
import WebSocket


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
    = SendWsMessage String
    | ReceiveWsMessage String
    | UpdateMessage String


websocketUrl =
    "ws://echo.websocket.org"


init =
    ( Model "" [], Cmd.none )


update msg model =
    case msg of
        UpdateMessage toUpdate ->
            ( { model | message = toUpdate }, Cmd.none )

        SendWsMessage toSend ->
            ( { model | message = "" }, WebSocket.send websocketUrl toSend )

        ReceiveWsMessage received ->
            ( { model | messages = (received :: model.messages) }, Cmd.none )


subscriptions model =
    WebSocket.listen websocketUrl ReceiveWsMessage


view : Model -> Html Msg
view model =
    let
        viewMessage message =
            li [] [ text message ]
    in
        div []
            [ input [ placeholder "Message", value model.message, onInput UpdateMessage ] []
            , button [ onClick (SendWsMessage model.message) ] [ text "send" ]
            , ul [] (List.map viewMessage model.messages)
            ]
