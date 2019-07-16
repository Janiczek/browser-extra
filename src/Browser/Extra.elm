module Browser.Extra exposing (viewportDecoder)

{-| Convenience functionality on
[`Browser`](http://package.elm-lang.org/packages/elm/browser/latest/Browser)-related types

@docs viewportDecoder

-}

import Browser.Dom exposing (Viewport)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Extra as Decode


{-| Parse the [`Viewport`](https://package.elm-lang.org/packages/elm/browser/latest/Browser-Dom#Viewport) from eg. a `scroll` event.

This is an Elm-only version of what [`Browser.Dom.getViewportOf`](https://package.elm-lang.org/packages/elm/browser/latest/Browser-Dom#getViewportOf) does.

-}
viewportDecoder : Decoder Viewport
viewportDecoder =
    Decode.field "target"
        (Decode.succeed
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
            |> Decode.andMap (Decode.field "scrollWidth" Decode.float)
            |> Decode.andMap (Decode.field "scrollHeight" Decode.float)
            |> Decode.andMap (Decode.field "scrollLeft" Decode.float)
            |> Decode.andMap (Decode.field "scrollTop" Decode.float)
            |> Decode.andMap (Decode.field "clientWidth" Decode.float)
            |> Decode.andMap (Decode.field "clientHeight" Decode.float)
        )
