module Evergreen.V1.Types exposing (..)

import Browser
import Browser.Dom
import Browser.Navigation
import Evergreen.V1.Authentication
import Evergreen.V1.Data
import Evergreen.V1.User
import Http
import Markdown.Render
import Random
import Time
import Url


type AppMode
    = EntryMode
    | EditMode


type ViewMode
    = Expanded
    | Collapsed


type PopupWindow
    = AdminPopup


type PopupStatus
    = PopupOpen PopupWindow
    | PopupClosed


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , url : Url.Url
    , message : String
    , currentTime : Time.Posix
    , zone : Time.Zone
    , randomSeed : Random.Seed
    , appMode : AppMode
    , users : List Evergreen.V1.User.User
    , currentUser : Maybe Evergreen.V1.User.User
    , inputUsername : String
    , inputPassword : String
    , snippetText : String
    , snippets : List Evergreen.V1.Data.Datum
    , currentSnippet : Maybe Evergreen.V1.Data.Datum
    , inputSnippetFilter : String
    , viewMode : ViewMode
    , windowWidth : Int
    , windowHeight : Int
    , popupStatus : PopupStatus
    }


type alias BackendModel =
    { message : String
    , randomSeed : Random.Seed
    , randomAtmosphericInt : Maybe Int
    , currentTime : Time.Posix
    , dataDict : Evergreen.V1.Data.DataDict
    , authenticationDict : Evergreen.V1.Authentication.AuthenticationDict
    }


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | GotViewport Browser.Dom.Viewport
    | NoOpFrontendMsg
    | FETick Time.Posix
    | GotAtomsphericRandomNumberFE (Result Http.Error String)
    | AdjustTimeZone Time.Zone
    | GotNewWindowDimensions Int Int
    | ChangePopupStatus PopupStatus
    | SignIn
    | SignOut
    | InputUsername String
    | InputPassword String
    | InputSnippet String
    | Save
    | EditItem Evergreen.V1.Data.Datum
    | Delete
    | InputSnippetFilter String
    | ExpandContractItem Evergreen.V1.Data.Datum
    | RandomOrder
    | ModificationOrder
    | RandomizedOrder (List Evergreen.V1.Data.Datum)
    | MarkdownMsg Markdown.Render.MarkdownMsg
    | AdminRunTask
    | GetUsers


type alias Username =
    String


type ToBackend
    = NoOpToBackend
    | RunTask
    | SendUsers
    | SaveDatum Username Evergreen.V1.Data.Datum
    | SendUserData Username
    | UpdateDatum Username Evergreen.V1.Data.Datum
    | DeleteSnippetFromStore Username Evergreen.V1.Data.DataId
    | SignInOrSignUp String String


type BackendMsg
    = NoOpBackendMsg
    | GotAtomsphericRandomNumber (Result Http.Error String)
    | Tick Time.Posix


type ToFrontend
    = NoOpToFrontend
    | SendMessage String
    | GotUsers (List Evergreen.V1.User.User)
    | GotUserData (List Evergreen.V1.Data.Datum)
    | SendUser Evergreen.V1.User.User
