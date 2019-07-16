module BrowserExtraTest exposing (suite)

import Browser.Dom exposing (Viewport)
import Browser.Extra
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Json.Decode as Decode
import Test exposing (..)


suite : Test
suite =
    describe "Browser.Extra"
        [ describe "viewportDecoder"
            [ test "works" <|
                \() ->
                    let
                        input : String
                        input =
                            """{
                            "target": {
                                "scrollWidth": 1.2,
                                "scrollHeight": 3.4,
                                "scrollLeft": 5.6,
                                "scrollTop": 7.8,
                                "clientWidth": 9.1,
                                "clientHeight": 2.3
                            }
                        }"""

                        output : Viewport
                        output =
                            { scene =
                                { width = 1.2
                                , height = 3.4
                                }
                            , viewport =
                                { x = 5.6
                                , y = 7.8
                                , width = 9.1
                                , height = 2.3
                                }
                            }
                    in
                    Decode.decodeString Browser.Extra.viewportDecoder input
                        |> Expect.equal (Ok output)
            ]
        ]
