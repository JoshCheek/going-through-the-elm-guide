-- Trying it myself before reading any further:

{- Here we will make a rudimentary form.
   It has a field for your name,
   a field for your password,
   and a field to verify that password.

   We will also do some very simple validation
   (do the two passwords match?) just because it is simple to add.
-}

import Html exposing (Html, input, text, form, p, dl, dt, dd, div, h2, hr)
import Html.App as Html
import Html.Attributes exposing (type', style, value, placeholder, autofocus)
import Html.Events exposing (onInput, onSubmit)

main =
  Html.beginnerProgram { model = blankForm, update = update, view = view }


type alias FormData =
  { name                 : String
  , password             : String
  , passwordConfirmation : String
  , messages             : List String
  , status               : FormStatus
  }

type FormStatus = Unsubmitted | Error | Success
type Msg = UpdateName String
         | UpdatePassword String
         | UpdatePasswordConfirmation String
         | Submit

blankForm : FormData
blankForm =
  { name                 = ""
  , password             = ""
  , passwordConfirmation = ""
  , messages             = []
  , status               = Unsubmitted
  }


update : Msg -> FormData -> FormData
update msg formData =
  case msg of
    UpdateName newName ->
      { formData | name = newName }
    UpdatePassword newPass ->
      { formData | password = newPass }
    UpdatePasswordConfirmation newPassConf ->
      { formData | passwordConfirmation = newPassConf }
    Submit ->
      if formData.password /= formData.passwordConfirmation
      then
        { formData
        | password = blankForm.password
        , passwordConfirmation = blankForm.passwordConfirmation
        , status = Error
        , messages = ["Password did not match confirmation"]
        }
      else
       { formData | status = Success, messages = ["Your account has been created!"] }

view : FormData -> Html Msg
view formData =
  let notificationColor status =
    case status of
      Unsubmitted -> "#AA0"
      Error       -> "#A00"
      Success     -> "#0A0"
  in div
       [ style [("margin", "2em")]
       ]
       [ h2 [] [text "Form"]
       , form
           [ onSubmit Submit
           , style
               [ ("color", notificationColor formData.status)
               ]
           ]
           [ p [ style [("font-weight", "bold")]
               ]
               (List.map text formData.messages)
           , input [type' "text"
                   , value formData.name
                   , onInput UpdateName
                   , placeholder "name"
                   , autofocus True
                   ]
                   []
           , input [type' "password"
                   , value formData.password
                   , onInput UpdatePassword
                   , placeholder "password"
                   ]
                   []
           , input [type' "password"
                   , value formData.passwordConfirmation
                   , onInput UpdatePasswordConfirmation
                   , placeholder "password confirmation"
                   ]
                   []
           , input [type' "submit"] []
           ]
       , hr [style [("margin-top", "2em")]] []
       , h2 [] [text "Underlying Data"]
       , dl
           []
           [ dt [] [text "name"]
           , dd [] [text (toString formData.name)]
           , dt [] [text "password"]
           , dd [] [text (toString formData.password)]
           , dt [] [text "passwordConfirmation"]
           , dd [] [text (toString formData.passwordConfirmation)]
           , dt [] [text "messages"]
           , dd [] [text (toString formData.messages)]
           , dt [] [text "status"]
           , dd [] [text (toString formData.status)]
           ]
       ]

