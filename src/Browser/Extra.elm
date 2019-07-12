module Browser.Extra exposing (viewportDecoder)

{-| TODO
-}

import Browser.Dom exposing (Viewport)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Extra as Decode


{-| TODO
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
