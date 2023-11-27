module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, section, input, label, span)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (style, placeholder, value, type_)

-- MAIN

main : Program () Model Msg
main = 
  Browser.sandbox { init = init, update = update, view = view }


-- MODEL

type alias Model = 
  { initalValue : Float
  , years : Float
  , percent : Float
  , result : Float
  }


init : Model
init =
  Model 0.0 0.0 0.0 0.0


type Msg
  = Calculate
  | ChangeInitalValue String
  | ChangePercentValue String
  | ChangeYearsValue String


-- UPDATE


update : Msg -> Model -> Model
update msg model =
  case msg of
    Calculate ->
      { model | result = (model.initalValue * model.percent) * model.years  }

    ChangeInitalValue initalValue  ->
      { model | initalValue = initalValue |> String.toFloat |> Maybe.withDefault 0 }

    ChangePercentValue percentValue -> 
      { model | percent = percentValue |> String.toFloat |> Maybe.withDefault 0 }

    ChangeYearsValue yearsValue -> 
      { model | years = yearsValue |> String.toFloat |> Maybe.withDefault 0 }


-- VIEW


view : Model -> Html Msg
view model =
  sectionView [
      divView [ 
        span [] [ text (String.fromFloat model.result) ]
      , inputView model.initalValue "$ 1000.00" "Inital Value:" ChangeInitalValue
      , inputView model.percent "0.12" "Percent:" ChangePercentValue
      , inputView model.years "10" "Years:" ChangeYearsValue
      , buttonView "Calculate"
      ]
  ]

sectionView : List (Html Msg) -> Html Msg
sectionView children = 
  section [
      style "height" "100vh"
    , style "display" "flex"
    , style "justify-content" "center"
    , style "align-items" "center" 
  ] children

divView : List (Html Msg) -> Html Msg
divView children = 
  div [
    style "display" "flex"
  , style "flex-direction" "column"
  ] children

inputView : Float -> String -> String -> (String -> msg) -> Html msg
inputView initalValue placeholderValue lableValue onChange = 
  label [ style "display" "flex", style "flex-direction" "column" ] 
  [ text lableValue
  , input [ 
      placeholder placeholderValue
    , value (String.fromFloat initalValue)
    , type_ "number"
    , onInput onChange
    ] [] 
  ]

buttonView : String -> Html Msg
buttonView buttonText =
  button [ 
      style "margin-top" "10px"
    , style "cursor" "pointer"
    , onClick Calculate 
    ] [ text buttonText ]