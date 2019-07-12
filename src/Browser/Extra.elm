module Browser.Extra exposing (viewportDecoder, mapDocument)

{-| Convenience functionality on
[`Browser`](http://package.elm-lang.org/packages/elm/browser/latest/Browser)-related types

@docs viewportDecoder, mapDocument

-}

import Browser
import Browser.Dom exposing (Viewport)
import Html
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Extra as Decode


{-| Parse the [`Viewport`](https://package.elm-lang.org/packages/elm/browser/latest/Browser-Dom#Viewport) from eg. a `scroll` event.

This is an Elm-only version of what [`Browser.Dom.getViewportOf`](https://package.elm-lang.org/packages/elm/browser/latest/Browser-Dom#getViewportOf) does.

-}
viewportDecoder : Decoder Viewport
viewportDecoder =
    Decode.succeed
        (\scrollWidth scrollHeight scrollLeft scrollTop clientWidth clientHeight ->
            { scene =
                { width = scrollWidth
                , height = scrollHeight
                }
            , viewport =
                { x = scrollLeft
                , y = scrollTop
                , width = clientWidth
                , height = clientHeight
                }
            }
        )
        |> Decode.andMap (Decode.at [ "target", "scrollWidth" ] Decode.float)
        |> Decode.andMap (Decode.at [ "target", "scrollHeight" ] Decode.float)
        |> Decode.andMap (Decode.at [ "target", "scrollLeft" ] Decode.float)
        |> Decode.andMap (Decode.at [ "target", "scrollTop" ] Decode.float)
        |> Decode.andMap (Decode.at [ "target", "clientWidth" ] Decode.float)
        |> Decode.andMap (Decode.at [ "target", "clientHeight" ] Decode.float)


{-| Map a [`Browser Document`](https://package.elm-lang.org/packages/elm/browser/latest/Browser#Document) from one `msg` type to another.

    type Msg
        = HomeMsg Home.Msg

    view : Page -> Browser.Document Msg
    view page =
        case page of
            Home model ->
                mapDocument HomeMsg (Home.view model)


    -- Home.elm
    view : Home.Model -> Browser.Document Home.Msg

-}
mapDocument : (a -> b) -> Browser.Document a -> Browser.Document b
mapDocument f document =
    { title = document.title
    , body = List.map (Html.map f) document.body
    }
