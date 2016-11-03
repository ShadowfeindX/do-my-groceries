module Main exposing (..)
import Dom
import Html exposing (..)
import Html.Attributes exposing (..)

--script : String -> List (Attribute msg) -> Html msg
script attributes children =
    node "script" attributes [text children]

main =
  let
    text = "Hello from Elm!"
  in
    div [] (view model)


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
      a [ class "item" ] [
        text item,
        div [ class "ui tag label" ] [ text ("$" ++ toString(price)) ]
      ]
  in
    [
      div [ class "ui action input" ] [
        input [ type' "text", placeholder "Item" ] [],
        div [ class "ui labeled input" ] [
          div [ class "ui label" ] [ text "$" ],
          input [ type' "text", placeholder "Price" ] []
        ],
        button [ id "add button", class "ui button" ] [ text "Add" ],
        script [ id "my-script" ] """
        alert("behold my mighty power!");
        alert("tremble in fear elm");
        """
      ],
      dropdownTest1,
      dropdownTest2,
      div [ class "ui divided selection list" ] (List.map display model)
    ]

dropdownTest1 =
  div [class "ui simple compact selection dropdown"] [
    input [name "gender"][],
    i [class "dropdown icon"][],
    div [class "default text"] [text "Gender"],
    div [class "menu"] [
      div [class "item"] [text "Male"],
      div [class "item"] [text "Female"]
    ]
  ]
dropdownTest2 =
  div [class "ui compact selection dropdown"] [
    input [name "gender"][],
    i [class "dropdown icon"][],
    div [class "default text"] [text "Gender"],
    div [class "menu"] [
      div [class "item"] [text "Male"],
      div [class "item"] [text "Female"]
    ]
  ]

buttonTest =
  div [ class "ui buttons" ] [
    button [ class "ui button" ] [ text "Edit" ],
    div [ class "or" ] [],
    button [ class "ui negative button" ] [ text "Delete" ]
  ]