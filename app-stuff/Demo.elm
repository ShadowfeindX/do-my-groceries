
import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Html.App as App

import Material
import Material.Color as Color
import Material.Layout as Layout
import Material.Options as Options exposing (css, when)
import Material.Scheme as Scheme
import Material.Icon as Icon

--import Components.Template


-- MODEL



type alias Model =
  { mdl : Material.Model
  , tab : Int
  --, template : Components.Template.Model
  }


model : Model
model =
  { mdl = Material.model
  , tab = 0
  --, template = Components.Template.model
  }



-- ACTION, UPDATE


type Msg
  = SelectTab Int
  | Mdl (Material.Msg Msg)
  --| TemplateMsg Components.Template.Msg



update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
  case action of
    Mdl msg ->
      Material.update msg model
    _ -> ( model, Cmd.none )
    --TemplateMsg  a -> lift  .template   (\m x->{m|template  =x}) TemplateMsg Components.Template.update   a model


-- VIEW



drawer : List (Html Msg)
drawer =
  [ Layout.title [] [ text "Example drawer" ]
  , Layout.navigation
    []
    [  Layout.link
        [ Layout.href "https://github.com/debois/elm-mdl" ]
        [ text "github" ]
    , Layout.link
        [ Layout.href "http://package.elm-lang.org/packages/debois/elm-mdl/latest/" ]
        [ text "elm-package" ]
    , Layout.link
        [ Layout.href "#cards"
        , Layout.onClick (Layout.toggleDrawer Mdl)
        ]
        [ text "Card component" ]
    ]
  ]


header : Model -> List (Html Msg)
header model =
    [ Layout.row
        [ css "transition" "height 333ms ease-in-out 0s" ]
        [ Layout.title [] [ text "elm-mdl" ]
        , Layout.spacer
        , Layout.navigation []
            [ Layout.link
                [ Layout.href "https://github.com/debois/elm-mdl"]
                [ Icon.i "photo" ]
            , Layout.link
                [ Layout.href "https://github.com/debois/elm-mdl"]
                [ span [] [text "github"] ]
            , Layout.link
                [ Layout.href "http://package.elm-lang.org/packages/debois/elm-mdl/latest/" ]
                [ text "elm-package" ]
            ]
        ]
    ]


view : Model -> Html Msg
view model =
  let
    top =
      text "Hello from Elm!"
  in
    Layout.render Mdl model.mdl
      [ Layout.selectedTab model.tab
      , Layout.onSelectTab SelectTab
      , Layout.fixedHeader
      , Layout.fixedTabs
      , Layout.scrolling
      ]
      { header = header model
      , drawer = drawer 
      , tabs = ([], [])
      , main = [ stylesheet, top ]
      }
    {- ** The following lines are not necessary when you manually set up
       your html, as done with page.html. Removing it will then
       fix the flicker you see on load.
    -}
    |> (\contents ->
        div []
          [ Scheme.topWithScheme Color.Blue Color.Amber contents
          , Html.node "script"
             [ Html.Attributes.attribute "src" "https://cdn.polyfill.io/v2/polyfill.js?features=Event.focusin" ]
             []
          , Html.node "script"
             [ Html.Attributes.attribute "src" "assets/highlight/highlight.pack.js" ]
             []
          ]
        )


-- ROUTING


{-urlOf : Model -> String
urlOf model =
  "#" ++ (Array.get model.selectedTab tabUrls |> Maybe.withDefault "")


delta2url : Model -> Model -> Maybe Routing.UrlChange
delta2url model1 model2 =
  if model1.selectedTab /= model2.selectedTab then
    { entry = Routing.NewEntry
    , url = urlOf model2
    } |> Just
  else
    Nothing


location2messages : Navigation.Location -> List Msg
location2messages location =
  [ case String.dropLeft 1 location.hash of
      "" ->
        SelectTab 0

      x ->
        Dict.get x urlTabs
          |> Maybe.withDefault -1
          |> SelectTab
  ]-}



-- APP


main : Program Never
main =
  let
    {- elm gives us no way to measure the actual width of tabs. We
     hardwire it. If you add a tab, remember to update this. Find the
     new value using: 

     document.getElementsByClassName("mdl-layout__tab-bar")[0].scrollWidth
    -}
    init = ( { model | mdl = Layout.setTabsWidth 2124 model.mdl }, Material.init Mdl )
    subscriptions model = Sub.batch [ Material.subscriptions Mdl model ]
  in
    App.program
      { init = init
      , view = view
      , subscriptions = subscriptions
      , update = update
      }

{-  Routing.program
    { delta2url = delta2url
    , location2messages = location2messages
    , init =
        ( { model
          | mdl = Layout.setTabsWidth 2124 model.mdl
           elm gives us no way to measure the actual width of tabs. We
             hardwire it. If you add a tab, remember to update this. Find the
             new value using: 

             document.getElementsByClassName("mdl-layout__tab-bar")[0].scrollWidth
          
          }
          , Material.init Mdl
        )
    , view = view
    , subscriptions = \model ->
        Sub.batch
        [ Sub.map MenusMsg (Menu.subs Demo.Menus.Mdl model.menus.mdl)
        , Material.subscriptions Mdl model 
        ]
    , update = update
    }
-}

-- CSS


stylesheet : Html Msg
stylesheet =
  Options.stylesheet """
  /* The following line is better done in html. We keep it here for
     compatibility with elm-reactor.
   */
  @import url("assets/highlight/github-gist.css");

  blockquote:before { content: none; }
  blockquote:after { content: none; }
  blockquote {
    border-left-style: solid;
    border-width: 1px;
    padding-left: 1.3ex;
    border-color: rgb(255,82,82);
      /* Really need a way to specify "secondary color" in
         inline css.
       */
    font-style: normal;
  }
  p, blockquote {
    max-width: 40em;
  }

  pre {
    display: inline-block;
    box-sizing: border-box;
    min-width: 100%;
    padding-top: .5rem;
    padding-bottom: 1rem;
    padding-left:1rem;
    margin: 0;
  }
  code {
    font-family: 'Roboto Mono';
  }
  .mdl-layout__header--transparent {
    background: url('https://getmdl.io/assets/demos/transparent.jpg') center / cover;
  }
  .mdl-layout__header--transparent .mdl-layout__drawer-button {
    /* This background is dark, so we set text to white. Use 87% black instead if
       your background is light. */
    color: white;
  }
"""
