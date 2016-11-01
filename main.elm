module Main exposing (..)

import Html

main =
  let
    text = "Hello from Elm!"
  in
    Html.div [][ view model ]


model =
  [
    ("Apples", 1.45),
    ("Bananas", 1.22),
    ("Oreos", 2.67),
    ("Chicken Breast", 5.77)
  ]

view model =
  let
    display (item,price) =
      Html.li [][ Html.text (item ++ " - $" ++ toString(price)) ]
  in
    Html.ul [] (List.map display model)