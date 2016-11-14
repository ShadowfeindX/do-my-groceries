module Main exposing (..)

-- HTML

import Html
import Html.App as App
import Html.Events as Events
import Html.Attributes as Attributes


-- MATERIAL

import Material
import Material.Elevation as Elevation
import Material.Menu as Menu
import Material.Helpers as Helpers
import Material.List as List
import Material.Color as Color
import Material.Scheme as Scheme
import Material.Layout as Layout


-- COMPONENTS

import Maybe exposing (..)
import Array exposing (..)
import List exposing (..)
import List.Extra exposing (..)


-- TYPES


type alias Model =
    { mdl : Material.Model
    , currentTab : Int
    , currentStore : Store
    , stores : List Store
    }


type alias Store =
    { name : String
    , stock : Int
    , inventory : List Item
    }


type alias Item =
    { price : Float
    , name : String
    , img : String
    }


type Msg
    = Mdl (Material.Msg Msg)
    | SelectTab Int
    | SelectStore Int



-- MAIN


main =
    let
        init =
            model ! [ Material.init Mdl ]

        subs model =
            Sub.batch [ Material.subscriptions Mdl model ]
    in
        App.program
            { init = init
            , subscriptions = subs
            , update = controller
            , view = view
            }



-- MODEL, VIEW, CONTROLLER


model =
    { mdl = Material.model
    , currentTab = 0
    , currentStore =
        { name = ""
        , stock = 0
        , inventory = []
        }
    , stores =
        let
            testdata =
                [ { name = "Walmart", stock = 1, inventory = [ { price = 3.75, name = "Apples", img = "" } ] }
                , { name = "Target", stock = 1, inventory = [ { price = 4.21, name = "Oranges", img = "" } ] }
                , { name = "Food Lion", stock = 1, inventory = [ { price = 4.22, name = "Milk", img = "" } ] }
                ]

            stock =
                testdata
                    |> List.map .stock
                    |> List.foldl (+) 0

            inventory =
                testdata
                    |> List.map .inventory
                    |> List.foldl (++) []
                    |> List.sortBy .name
                    |> uniqueBy .name
        in
            { name = "All", stock = stock, inventory = inventory } :: testdata
    }


view model =
    let
        tabs =
            [ Html.text "Stores", Html.text "Groceries", Html.text "Recipes" ]

        menu =
            Menu.render Mdl
                [ 0 ]
                model.mdl
                [ Menu.ripple, Menu.bottomRight ]
                [ Menu.item [] [ Html.text "Add Item" ]
                , Menu.item [] [ Html.text "Add List" ]
                , Menu.item [] [ Html.text "Delete List" ]
                ]

        header =
            Layout.row []
                [ Layout.title []
                    [ Html.text "Do My Groceries" ]
                , Layout.spacer
                , menu
                ]

        drawer =
            let
                storelink i store =
                    Layout.link [ Layout.onClick <| SelectStore i ] [ Html.text store.name ]

                stores =
                    List.indexedMap storelink model.stores
            in
                Layout.navigation [] stores

        pages =
            { stores =
                let
                    inventory =
                        model.currentStore
                            |> .inventory
                            |> List.map stock

                    stock item =
                        List.li []
                            [ List.content []
                                [ Html.text <| item.name ++ " - $" ++ toString item.price ]
                            ]
                in
                    List.ul [] inventory
            , groceries =
                menu
                --Html.body [] [ Html.text "Page 2" ]
            , recipes = Html.body [] [ Html.text "Page 3" ]
            }

        main ( pages, tab ) =
            case tab of
                0 ->
                    pages.stores

                1 ->
                    pages.groceries

                2 ->
                    pages.recipes

                _ ->
                    Html.body [] []
    in
        Layout.render Mdl
            model.mdl
            [ Layout.fixedHeader
            , Layout.fixedDrawer
            , Layout.selectedTab model.currentTab
            , Layout.onSelectTab SelectTab
            ]
            { header = [ header ]
            , drawer = [ drawer ]
            , tabs = ( tabs, [ Color.background <| Color.color Color.Amber Color.A700 ] )
            , main = [ main ( pages, model.currentTab ) ]
            }
            |> Scheme.topWithScheme Color.Blue Color.Amber


controller msg model =
    case msg of
        Mdl action ->
            Material.update action model

        SelectTab tab ->
            { model | currentTab = tab } ! []

        SelectStore store ->
            let
                currentStore =
                    model.stores
                        !! store
                        |> withDefault model.currentStore

                new =
                    { model | currentStore = currentStore }

                cmd =
                    Helpers.cmd <| Layout.toggleDrawer Mdl
            in
                new ! [ cmd ]



--    _ ->
--        ( model, Cmd.none )
