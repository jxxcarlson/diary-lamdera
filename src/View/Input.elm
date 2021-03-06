module View.Input exposing
    ( passwordInput
    , snippetFilter
    , editDiaryEntry
    , usernameInput
    )

import Element as E exposing (Element, px)
import Element.Background as Background
import Element.Font as Font
import Element.Input as Input
import Types exposing (AppMode(..), FrontendModel, FrontendMsg(..))
import View.Color as Color


inputFieldTemplate : E.Length -> E.Length -> String -> (String -> msg) -> String -> Element msg
inputFieldTemplate width_ height_ default msg text =
    Input.text [ E.moveUp 5, Font.size 16, E.height height_, E.width width_ ]
        { onChange = msg
        , text = text
        , label = Input.labelHidden default
        , placeholder = Just <| Input.placeholder [ E.moveUp 5 ] (E.text default)
        }


multiLineTemplate : List (E.Attribute msg) -> E.Length -> E.Length -> String -> (String -> msg) -> String -> Element msg
multiLineTemplate attrList width_ height_ default msg text =
    Input.multiline ([ E.moveUp 5, Font.size 16, E.height height_, E.width width_ ] ++ attrList)
        { onChange = msg
        , text = text
        , label = Input.labelHidden default
        , placeholder = Just <| Input.placeholder [ E.moveUp 5 ] (E.text default)
        , spellcheck = False
        }


passwordTemplate : E.Length -> String -> (String -> msg) -> String -> Element msg
passwordTemplate width_ default msg text =
    Input.currentPassword [ E.moveUp 5, Font.size 16, E.height (px 33), E.width width_ ]
        { onChange = msg
        , text = text
        , label = Input.labelHidden default
        , placeholder = Just <| Input.placeholder [ E.moveUp 5 ] (E.text default)
        , show = False
        }


usernameInput model =
    inputFieldTemplate (E.px 120) (E.px 33) "Username" InputUsername model.inputUsername


snippetFilter model width_ =
    inputFieldTemplate (E.px width_) (E.px 33) "Filter ..." InputSnippetFilter model.inputSnippetFilter


editDiaryEntry : FrontendModel -> Int -> String -> Element FrontendMsg
editDiaryEntry model width_ text_ =
    let
        attrs =
            case model.appMode of
                EntryMode ->
                    [ Background.color Color.paleViolet, E.scrollbarY ]

                EditMode ->
                    [ Background.color Color.palePink, E.scrollbarY ]
    in
    multiLineTemplate attrs (E.px width_) (E.px 200) "Diary" InputSnippet text_


passwordInput model =
    passwordTemplate (E.px 120) "Password" InputPassword model.inputPassword
