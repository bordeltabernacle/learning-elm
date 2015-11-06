module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import String exposing (toUpper, repeat, trimRight)

newEntry phrase points id =
  { phrase = phrase,
    points = points,
    wasSpoken = False,
    id = id
  }

title message times =
  message ++ " "
  |> toUpper
  |> repeat times
  |> trimRight
  |> text

pageHeader =
  h1 [ ] [ title "bingo!" 3 ]

pageFooter =
  footer [ ]
    [ a [ href "http://pragmaticstudio.com" ]
        [ text "The Pragmatic Studio"]
    ]

entryItem entry =
  li [ ]
    [ span [ class "phrase" ] [ text entry.phrase ],
      span [ class "points" ] [ text (toString entry.points) ]
    ]

entryList =
  ul [ ]
    [ entryItem (newEntry "Future-Proof" 100 1),
      entryItem (newEntry "Doing Agile" 200 2),
      entryItem (newEntry "Network Automation" 250 3)
    ]

view =
  div [ id "container" ]
    [ pageHeader
    , entryList
    , pageFooter
    ]


main =
  view
