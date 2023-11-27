module Utils exposing (..)

parseFloat : String -> Float
parseFloat stringValue =
  stringValue
  |> String.toFloat
  |> Maybe.withDefault 0
