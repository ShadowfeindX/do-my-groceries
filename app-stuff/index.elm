module Index exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)

main =
  div []
    [ p [ attribute "style" "text-align: center; font-size: 15px;" ]
        [ img [ alt "TinyMCE Logo", attribute "height" "97", src "//www.tinymce.com/images/glyph-tinymce@2x.png", title "TinyMCE Logo", attribute "width" "110" ]
            []
        ]
    , h1 [ attribute "style" "text-align: center;" ]
        [ text "Welcome to the TinyMCE editor demo!" ]
    , h5 [ attribute "style" "text-align: center;" ]
        [ text "Note, this is not an \"enterprise/premium\" demo."
        , br []
            []
        , text "Visit the "
        , a [ href "https://www.tinymce.com/pricing/#demo-enterprise" ]
            [ text "pricing page" ]
        , text "to demo our premium plugins."
        ]
    , p []
        [ text "Please try out the features provided in this full featured example." ]
    , p []
        [ text "Note that any "
        , strong []
            [ text "MoxieManager" ]
        , text "file and image management functionality in this example is part of our commercial offering &ndash; the demo is to show the integration."
        ]
    , h2 []
        [ text "Got questions or need help?" ]
    , ul []
        [ li []
            [ text "Our "
            , a [ href "//www.tinymce.com/docs/" ]
                [ text "documentation" ]
            , text "is a great resource for learning how to configure TinyMCE."
            ]
        , li []
            [ text "Have a specific question? Visit the "
            , a [ href "http://community.tinymce.com/forum/" ]
                [ text "Community Forum" ]
            , text "."
            ]
        , li []
            [ text "We also offer enterprise grade support as part of "
            , a [ href "http://tinymce.com/pricing" ]
                [ text "TinyMCE Enterprise" ]
            , text "."
            ]
        ]
    , h2 []
        [ text "A simple table to play with" ]
    , table [ attribute "style" "text-align: center;" ]
        [ thead []
            [ tr []
                [ th []
                    [ text "Product" ]
                , th []
                    [ text "Cost" ]
                , th []
                    [ text "Really?" ]
                ]
            ]
        , tbody []
            [ tr []
                [ td []
                    [ text "TinyMCE" ]
                , td []
                    [ text "Free" ]
                , td []
                    [ text "YES!" ]
                ]
            , tr []
                [ td []
                    [ text "Plupload" ]
                , td []
                    [ text "Free" ]
                , td []
                    [ text "YES!" ]
                ]
            ]
        ]
    , h2 []
        [ text "Found a bug?" ]
    , p []
        [ text "If you think you have found a bug please create an issue on the "
        , a [ href "https://github.com/tinymce/tinymce/issues" ]
            [ text "GitHub repo" ]
        , text "to report it to the developers."
        ]
    , h2 []
        [ text "Finally ..." ]
    , p []
        [ text "Don't forget to check out our other product "
        , a [ href "http://www.plupload.com", target "_blank" ]
            [ text "Plupload" ]
        , text ", your ultimate upload solution featuring HTML5 upload support."
        ]
    , p []
        [ text "Thanks for supporting TinyMCE! We hope it helps you and your users create great content."
        , br []
            []
        , text "All the best from the TinyMCE team."
        ]
    ]