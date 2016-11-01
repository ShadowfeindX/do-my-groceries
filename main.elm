module Main exposing (..)

import Html
import Html.Attributes exposing (..)

main =
  let
    text = "Hello from Elm!"
  in
    Html.div [] (view model)


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
      Html.li [][
        Html.div [ ] [
          Html.text (item ++ " - $" ++ toString(price)),
          Html.button [ class "ui button" ] [ Html.text "Edit" ],
          Html.button [ class "ui button" ] [ Html.text "Delete" ]
        ]
      ]
  in
    [
      Html.div [ class "ui action input" ] [
        Html.input [ type' "text", placeholder "Item" ] [],
        Html.div [ class "ui labeled input" ] [
          Html.div [ class "ui label" ] [ Html.text "$" ],
          Html.input [ type' "text", placeholder "Price" ] []
        ],
        Html.button [ class "ui button" ] [ Html.text "Add" ]
      ],
      Html.ul [] (List.map display model)
    ]