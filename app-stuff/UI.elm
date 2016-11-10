module UI exposing (..)

-- HTML

import Html
import Html.App as App
import Html.Events as Events
import Html.Attributes as Attributes


-- MATERIAL

import Material
import Material.List as List
import Material.Color as Color
import Material.Scheme as Scheme
import Material.Layout as Layout


-- COMPONENTS
-- TYPES


type alias Model =
    { mdl : Material.Model
    , currentStore : Store
    , currentTab : Int
    , totalStores : Int
    }


type alias Store =
    { name : String
    , stock : Int
    , inventory : List Item
    }


type alias Item =
    { cost : Float
    , name : String
    , img : String
    }


type Msg
    = Mdl (Material.Msg Msg)
    | SelectTab Int
    | SelectStore String



-- MAIN


main =
    let
        init =
            ( model, Cmd.batch [ Material.init Mdl ] )

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
    , currentStore =
        { name = "All"
        , stock = 0
        , inventory = []
        }
    , currentTab = 0
    , totalStores = 3
    }


view model =
    let
        tabs =
            [ Html.text "Stores", Html.text "Groceries", Html.text "Recipes" ]

        header =
            Layout.row []
                [ Layout.title []
                    [ Html.text "Do My Groceries" ]
                ]

        drawer =
            Layout.navigation []
                [ Layout.link [ Layout.onClick <| SelectStore "All" ] [ Html.text "All" ]
                , Layout.link [ Layout.onClick <| SelectStore "Walmart" ] [ Html.text "Walmart" ]
                , Layout.link [ Layout.onClick <| SelectStore "Target" ] [ Html.text "Target" ]
                , Layout.link [ Layout.onClick <| SelectStore "Food Lion" ] [ Html.text "Food Lion" ]
                ]

        pages =
            { stores =
                List.ul []
                    [ List.li []
                        [ List.content [] [ Html.text model.currentStore.name ] ]
                    , List.li []
                        [ List.content [] [ Html.text model.currentStore.name ] ]
                    , List.li []
                        [ List.content [] [ Html.text model.currentStore.name ] ]
                    ]
            , groceries = Html.body [] [ Html.text "Page 2" ]
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
            , Layout.waterfall False
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
            ( { model
                | currentTab = tab
              }
            , Cmd.none
            )

        SelectStore store ->
            let
                newModel =
                    model.currentStore

                currentStore =
                    { newModel | name = store }
            in
                ( { model | currentStore = currentStore }, Cmd.map Mdl Layout.toggleDrawer )



--    _ ->
--        ( model, Cmd.none )
